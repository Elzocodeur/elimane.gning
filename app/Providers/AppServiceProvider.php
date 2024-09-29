<?php

namespace App\Providers;

use App\Models\ApprenantFirebaseModel;
use App\Models\PromotionFirebaseModel;
use Illuminate\Support\ServiceProvider;

use App\Repositories\UserRepositoryImplement;
use App\Repositories\Interfaces\UserRepositoryInterface;
use App\Models\ReferencielFirebaseModel;

use Kreait\Firebase\Factory;
use Kreait\Firebase\Database;
use Psr\Http\Message\UriInterface; //

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(UserRepositoryInterface::class, UserRepositoryImplement::class);

        // Assurez-vous d'avoir le binding Firebase
        $this->app->singleton(Database::class, function ($app) {
            return (new Factory)
                ->withServiceAccount(config('services.firebase.credentials'))
                ->withDatabaseUri(config('services.firebase.database_url')) // Pas besoin de withStorageBucket()
                ->createDatabase();
        });



        // base64
        // Assurez-vous d'avoir le binding Firebase
        // $this->app->singleton(Database::class, function ($app) {
        //     $firebaseCredentials = base64_decode(env('FIREBASE_CREDENTIALS'));
        //     dd($firebaseCredentials);
        //     return (new Factory)
        //         ->withServiceAccount(json_decode($firebaseCredentials, true))
        //         ->withDatabaseUri(config('services.firebase.database_url')) // Pas besoin de withStorageBucket()
        //         ->createDatabase();
        // });



        // referentiel
        $this->app->singleton('referenciel', function ($app) {
            return new ReferencielFirebaseModel($app->make(Database::class));
        });


        // Binding du modèle PromotionFirebaseModel
        $this->app->singleton('promotion', function ($app) {
            return new PromotionFirebaseModel($app->make(Database::class));
        });

        // Binding du modèle ApprenantFirebaseModel
        $this->app->singleton('apprenant', function ($app) {
            return new ApprenantFirebaseModel($app->make(Database::class));
        });
    }



    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
