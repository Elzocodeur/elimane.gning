<?php
namespace App\Http\Middleware;

use Closure;
use App\Repositories\PromotionRepository;
use Illuminate\Http\Request;

class CheckPromotionStatus
{
    protected $promotionRepository;

    public function __construct(PromotionRepository $promotionRepository)
    {
        $this->promotionRepository = $promotionRepository;
    }

    public function handle(Request $request, Closure $next)
    {
        $promotionId = $request->route('id');
        $promotion = $this->promotionRepository->findPromotion($promotionId);

        if ($promotion && $promotion['etat'] === 'Clôturer') {
            if ($request->isMethod('post') || $request->isMethod('patch') || $request->isMethod('delete')) {
                return response()->json(['error' => 'Operation not allowed on a closed promotion'], 403);
            }
        }

        return $next($request);
    }
}
