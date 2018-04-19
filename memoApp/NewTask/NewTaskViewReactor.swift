//
//  NewTaskViewReactor.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/03/28.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import RxSwift
import RxCocoa
import ReactorKit

final class NewTaskViewReactor: Reactor {
    enum Action {
        case updateTitle(String?)
        case addTask()
    }

    enum Mutation {
        case setTitle(String?)
        case setTaskAuthenticated(Bool)
        case setTaskSaved(Bool)
    }

    struct State {
        var title: String?
        var isTaskAuthenticated = false
        var isTaskSaved = false
    }

    let initialState = State()
    private let realmService: RealmServiceType

    init(realmService: RealmServiceType) {
        self.realmService = realmService
    }

    func mutate(action: NewTaskViewReactor.Action) -> Observable<NewTaskViewReactor.Mutation> {
        switch action {
        case .updateTitle(let title):
            guard let title = title, !title.isEmpty else {
                return Observable.just(Mutation.setTaskAuthenticated(false))
            }
            return .concat([
                Observable.just(Mutation.setTitle(title)),
                Observable.just(Mutation.setTaskAuthenticated(true))
                ])
        case .addTask():
            guard let title = currentState.title else { return .empty() }
            realmService.saveTask(title: title)
            return Observable.just(Mutation.setTaskSaved(true))
        }
    }

    func reduce(state: NewTaskViewReactor.State, mutation: NewTaskViewReactor.Mutation) -> NewTaskViewReactor.State {
        var newState = state
        switch mutation {
        case .setTitle(let title):
            newState.title = title
            return newState
        case .setTaskAuthenticated(let isTaskAuthenticated):
            newState.isTaskAuthenticated = isTaskAuthenticated
            return newState
        case .setTaskSaved(let isTaskSaved):
            newState.isTaskSaved = isTaskSaved
            return newState
        }
    }
}
