<?php namespace App\Controller;

use Psr\Log\LoggerInterface;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Validation;

class HelloController
{
  /**
   * @Route("/hello")
   */
  public function helloAction(LoggerInterface $logger): Response
  {
    // Example logger
    $logger->info('I just got the logger');
    $logger->error('An error occurred');

    $logger->critical('I left the oven on!', [
        // include extra "context" info in your logs
        'cause' => 'in_hurry',
    ]);

    // Example validator
    $validator = Validation::createValidator();
    $violations = $validator->validate('Bernhard', [
        new Length(['min' => 10]),
        new NotBlank(),
    ]);
    
    if (0 !== count($violations)) {
        // there are errors, now you can show them
        foreach ($violations as $violation) {
            echo $violation->getMessage().'<br>';
        }
    }

    // $response = new Response();
    // $response->setContent(json_encode(array(
    //   'ping' => 'pong',
    // )));
    // $response->headers->set('Content-Type', 'application/json');
    
    // return $response;

    // Json respons
    return new JsonResponse(array('ping' => 'pong'));
  }
}
