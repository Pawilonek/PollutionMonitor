<?php namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class HelloController
{
  /**
   * @Route("/hello")
   */
  public function helloAction(): Response
  {
    // $response = new Response();
    // $response->setContent(json_encode(array(
    //   'ping' => 'pong',
    // )));
    // $response->headers->set('Content-Type', 'application/json');
    
    // return $response;

    return new JsonResponse(array('ping' => 'pong'));
  }
}
