//
//  DependencyResolving.swift
//  HorseStable
//
//  Created by Lukas Korinek on 28/05/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit
import Alamofire

protocol DependencyResolving {
    func resolveAuthenticatedAPIManager() -> APIManaging
    func resolveAPIManager() -> APIManaging
    
}

extension DependencyResolving {
    // MARK: - Main Tab Bar
    func resolveMainTabBarController() -> UITabBarController {
        let storyboard = UIStoryboard(name: "TabBarViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! TabBarViewController
        return viewController
    }
    
    func resolveLoginScene() -> LoginViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        viewController.viewModel = resolveLoginViewModel()
        return viewController
    }
    
    func resolveLoginViewModel() -> LoginViewModeling {
        return LoginViewModel(authService: resolveAuthService(), keychainManager: resolveKeychainManager())
    }
    
    func resolveRegisterScene() -> RegisterViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "RegisterViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! RegisterViewController
        viewController.viewModel = resolveRegisterViewModel()
        return viewController
    }
    
    func resolveRegisterViewModel() -> RegisterViewModel {
        return RegisterViewModel(authService: resolveAuthService())
    }
    
    // MARK: - Stable Scene
    func resolveStablesScene() -> StablesViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "StablesViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! StablesViewController
        viewController.viewModel = resolveStablesViewModel()
        return viewController
    }
    
    func resolveAddStableScene() -> AddStableViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddStableViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddStableViewController
        viewController.viewModel = resolveAddStableViewModel()
        return viewController
    }
    
    func resolveStablesViewModel() -> StablesViewModel {
        return StablesViewModel(authService: resolveAuthService())
    }
    
    func resolveAddStableViewModel() -> AddStableViewModel {
        return AddStableViewModel(stableService: resolveStablesService())
    }
    // MARK: - Horse Scene
    func resolveHorsesScene() -> HorsesViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "HorsesViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! HorsesViewController
        viewController.viewModel = resolveHorsesViewModel()
        return viewController
    }
    
    func resolveDetailScene(horse: Horse) -> DetailViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! DetailViewController
        viewController.viewModel = resolveDetailViewModel(horse: horse)
        return viewController
    }
    
    func resolveHorseDetailScene(horse: Horse) -> HorseDetailViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "HorseDetailViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! HorseDetailViewController
        viewController.viewModel = resolveHorseDetailViewModel(horse: horse)
        return viewController
    }
    
    func resolveAddHorseScene() -> AddHorseViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddHorseViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddHorseViewController
        viewController.viewModel = resolveAddHorseViewModel()
        return viewController
    }
    
    func resolveHorseWorksScene(horse: Horse) -> HorseWorksViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "HorseWorksViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! HorseWorksViewController
        viewController.viewModel = resolveHorseWorksViewModel(horse: horse)
        return viewController
    }
    
    func resolveHorseWorksViewModel(horse: Horse) -> HorseWorksViewModel {
        return HorseWorksViewModel(horse: horse, horsesService: resolveHorsesService(), worksService: resolveWorksService())
    }
    
    func resolveDetailViewModel(horse: Horse) -> DetailViewModel{
        return DetailViewModel(horse: horse)
    }
    
    func resolveHorseDetailViewModel(horse: Horse) -> HorseDetailViewModel{
        return HorseDetailViewModel(horse: horse, horsesService: resolveHorsesService())
    }
    
    func resolveAddHorseViewModel() -> AddHorseViewModel {
        return AddHorseViewModel(horsesService: resolveHorsesService())
    }
    
    func resolveHorsesViewModel() -> HorsesViewModel {
        return HorsesViewModel(horsesService: resolveHorsesService(), stableService: resolveStablesService())
    }
    
    func resolveHorsesService() -> HorsesService {
        return HorsesService(apiManager: resolveAuthenticatedAPIManager())
    }
    
    // MARK: - Work Place Scene
    func resolveWorkPlacesScene() -> WorkPlacesViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "WorkPlacesViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! WorkPlacesViewController
        viewController.viewModel = resolveWorkPlacesViewModel()
        return viewController
    }
    
    func resolveAddWorkPlaceScene() -> AddWorkPlaceViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddWorkPlaceViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddWorkPlaceViewController
        viewController.viewModel = resolveAddWorkPlaceViewModel()
        return viewController
    }
    
    func resolveWorkPlaceDetailScene(workPlace: WorkPlace) -> WorkPlaceDetailViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "WorkPlaceDetailViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! WorkPlaceDetailViewController
        viewController.viewModel = resolveWorkPlaceDetailViewModel(workPlace: workPlace)
        return viewController
    }
    
    func resolveWorkPlacesViewModel() -> WorkPlacesViewModel {
        return WorkPlacesViewModel(workPlaceService: resolveWorkPlaceService(), stableService: resolveStablesService() )
    }
    
    func resolveAddWorkPlaceViewModel() -> AddWorkPlaceViewModel {
        return AddWorkPlaceViewModel(workPlaceService: resolveWorkPlaceService())
    }
    
    func resolveWorkPlaceDetailViewModel(workPlace: WorkPlace) -> WorkPlaceDetailViewModel {
        return WorkPlaceDetailViewModel(workPlace: workPlace, workPlaceService: resolveWorkPlaceService())
    }
    
    // MARK: - Work Scene
    func resolveWorksScene() -> WorksViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "WorksViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! WorksViewController
        viewController.viewModel = resolveWorksViewModel()
        return viewController
    }
    
    func resolveWorkDetailScene(work: Work) -> WorkDetailViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "WorkDetailViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! WorkDetailViewController
        viewController.viewModel = resolveWorkDetailViewModel(work: work)
        return viewController
    }
    
    func resolveAddWorkScene(date: Date,horseID: Int?) -> AddWorkViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddWorkViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddWorkViewController
        viewController.viewModel = resolveAddWorkViewModel(date: date, horseID: horseID)
        return viewController
    }
    
    func resolveWorksViewModel() -> WorksViewModel {
        return WorksViewModel(worksService: resolveWorksService(),stableService: resolveStablesService())
    }
    
    func resolveWorkDetailViewModel(work: Work) -> WorkDetailViewModel{
        return WorkDetailViewModel(work: work, worksService: resolveWorksService(), stableService: resolveStablesService())
    }
    
    func resolveAddWorkViewModel(date: Date, horseID: Int?) -> AddWorkViewModel{
        return AddWorkViewModel(date: date, horseID: horseID,worksService: resolveWorksService(), stableService: resolveStablesService())
    }
    // MARK: - Settings Scene
    func resolveSettingsScene() -> SettingsViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! SettingsViewController
        viewController.viewModel = resolveSettingsViewModel()
        return viewController
    }
    
    func resolveSettingsViewModel() -> SettingsViewModeling {
        return SettingsViewModel(authService: resolveAuthService(), keychainManager: resolveKeychainManager())
    }
    // MARK: - Medical Scene
    func resolveMedicalScene(horse: Horse) -> MedicalViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "MedicalViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! MedicalViewController
        viewController.viewModel = resolveMedicalViewModel(horse: horse)
        return viewController
    }
    
    func resolveAddMedicalScene(horse: Horse) -> AddMedicalViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddMedicalViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddMedicalViewController
        viewController.viewModel = resolveAddMedicalViewModel(horse: horse)
        return viewController
    }
    
    func resolveMedicalViewModel(horse: Horse) -> MedicalViewModel {
        return MedicalViewModel(horse: horse, horseService: resolveHorsesService())
    }
    
    func resolveAddMedicalViewModel(horse: Horse) -> AddMedicalViewModel {
        return AddMedicalViewModel(horse: horse, medicalService: resolveMedicalService())
    }
    
    //MARK: - Feed Scene
    func resolveFeedScene(with feedType: FeedType) -> FeedViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "FeedViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! FeedViewController
        viewController.viewModel = resolveFeedViewModel(feedType: feedType)
        return viewController
    }
    
    func resolveAddFeedScene(feedType: FeedType) -> AddFeedViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddFeedViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddFeedViewController
        viewController.viewModel = resolveAddFeedViewModel(feedType: feedType)
        return viewController
    }
    
    func resolveFeedViewModel(feedType: FeedType) -> FeedViewModel {
        return FeedViewModel(feedType: feedType, feedTypeService: resolveFeedTypeService(), feedService: resolveFeedService())
    }
    
    func resolveAddFeedViewModel(feedType: FeedType) -> AddFeedViewModel {
        return AddFeedViewModel(feedType: feedType,feedService: resolveFeedService(), stableService: resolveStablesService())
    }
    
    //MARK: - FeedType Scene
    func resolveFeedTypesScene() -> FeedTypesViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "FeedTypesViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! FeedTypesViewController
        viewController.viewModel = resolveFeedTypesViewModel()
        return viewController
    }
    
    func resolveAddFeedTypeScene() -> AddFeedTypeViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "AddFeedTypeViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! AddFeedTypeViewController
        viewController.viewModel = resolveAddFeedTypeViewModel()
        return viewController
    }
    
    func resolveFeedTypeDetailScene(feedType: FeedType) -> FeedTypeDetailViewControlling & UIViewController {
        let storyboard = UIStoryboard(name: "FeedTypeDetailViewController", bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateInitialViewController() as! FeedTypeDetailViewController
        viewController.viewModel = resolveFeedTypeDetailViewModel(feedType: feedType)
        return viewController
    }
    
    func resolveFeedTypesViewModel() -> FeedTypesViewModel {
        return FeedTypesViewModel(feedTypeService: resolveFeedTypeService(),stableService: resolveStablesService())
    }
    
    func resolveAddFeedTypeViewModel() -> AddFeedTypeViewModel {
        return AddFeedTypeViewModel(feedTypeService: resolveFeedTypeService())
    }
    
    func resolveFeedTypeDetailViewModel(feedType: FeedType) -> FeedTypeDetailViewModel{
        return FeedTypeDetailViewModel(feedType: feedType, feedTypeService: resolveFeedTypeService())
    }
    
    //MARK: - Services
    func resolveWorksService() -> WorksService {
        return WorksService(apiManager: resolveAuthenticatedAPIManager())
    }
    
    func resolveAuthService() -> AuthService {
        return AuthService(apiManager: resolveAPIManager(), apiAuthManager: resolveAuthenticatedAPIManager())
    }
    
    func resolveStablesService() -> StableService {
        return StableService(apiManager: resolveAuthenticatedAPIManager())
    }
    
    func resolveMedicalService() -> MedicalService {
        return MedicalService(apiManager: resolveAuthenticatedAPIManager())
    }
    
    func resolveFeedTypeService() -> FeedTypeService {
         return FeedTypeService(apiManager: resolveAuthenticatedAPIManager())
     }
    
    func resolveFeedService() -> FeedService {
         return FeedService(apiManager: resolveAuthenticatedAPIManager())
     }
    
    func resolveWorkPlaceService() -> WorkPlaceService {
         return WorkPlaceService(apiManager: resolveAuthenticatedAPIManager())
     }
    
    func resolveKeychainManager() -> KeychainManaging {
        return KeychainManager()
    }
    
    // MARK: - Adapters
    func resolveAuthenticatedRequestAdapter() -> RequestAdapter {
        return TokenAdapter(keychainManager: resolveKeychainManager())
    }
    
}
