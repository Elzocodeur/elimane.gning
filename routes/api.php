<?php

use App\Http\Controllers\ApprenantController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\FirebaseUserController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ReferencielController;

use App\Http\Controllers\PromotionController;
use App\Http\Middleware\CheckPromotionStatus;




Route::prefix('v1/auth')->group(function () {
    Route::post('/login', [AuthController::class, 'login'])->name('login');
    Route::post('/token/refresh', [AuthController::class, 'refreshToken']);
});

Route::middleware('auth:api')->prefix('v1/auth')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
});



Route::middleware('auth:api')->prefix('v1')->group(function () {
    Route::post('/user/register', [UserController::class, 'register']);
    Route::get('/users', [UserController::class, 'index']);
    Route::patch('/users/{id}', [UserController::class, 'update']);

    // referenceils
    Route::post('/referentiels', [ReferencielController::class, 'store']);
    Route::get('/referentiels', [ReferencielController::class, 'index']);

    Route::patch('referentiels/{id}', [ReferencielController::class, 'update']);  // Mise à jour des informations du référentiel

    Route::post('referentiels/{id}/competences', [ReferencielController::class, 'addCompetence']);  // Ajouter une compétence

    Route::post('referentiels/{id}/competences/{competenceId}/modules', [ReferencielController::class, 'addModule']);  // Ajouter un module à une compétence

    Route::delete('referentiels/{id}/competences/{competenceId}', [ReferencielController::class, 'removeCompetence']);  // Supprimer une compétence (soft delete)

    Route::delete('referentiels/{id}/competences/{competenceId}/modules/{moduleId}', [ReferencielController::class, 'removeModule']);  // Supprimer un module d'une compétence


    // non swagger
    Route::delete('/referentiels/{id}', [ReferencielController::class, 'softDelete']);
    Route::get('/archive/referentiels', [ReferencielController::class, 'listDeleted']);


    // promotion
    Route::post('/promotions', [PromotionController::class, 'createPromotion']);
    Route::patch('/promotions/{id}', [PromotionController::class, 'updatePromotion']);
    Route::delete('/promotions/{id}', [PromotionController::class, 'deletePromotion']);
    Route::get('/promotions/deleted', [PromotionController::class, 'getDeletedPromotions']);
    Route::get('/promotions', [PromotionController::class, 'getAllPromotions']);



    Route::patch('promotions/{id}/cloturer', [PromotionController::class, 'cloturerPromotion'])
        ->middleware('auth');

    Route::group(['middleware' => ['auth', CheckPromotionStatus::class]], function () {
        Route::patch('promotions/{id}/refentiels', [PromotionController::class, 'updatePromotionReferentiels']);
        Route::patch('promotions/{id}/etat', [PromotionController::class, 'updatePromotionEtat']);
        Route::get('promotions/encours', [PromotionController::class, 'getActivePromotion']);
        Route::get('promotions/{id}/referentiels', [PromotionController::class, 'getPromotionReferentiels']);
    });




    // apprenant
    Route::post('apprenants', [ApprenantController::class, 'store']);

});


