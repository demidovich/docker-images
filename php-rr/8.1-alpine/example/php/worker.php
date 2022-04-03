<?php

declare(strict_types=1);

include 'vendor/autoload.php';

$worker = Spiral\RoadRunner\Worker::create();
$psr17Factory = new Nyholm\Psr7\Factory\Psr17Factory();
$psr7Worker = new Spiral\RoadRunner\Http\PSR7Worker($worker, $psr17Factory, $psr17Factory, $psr17Factory);

while ($req = $psr7Worker->waitRequest()) {
    try {
        $res = $psr17Factory->createResponse();
        $res->getBody()->write(
            phpinfoString()
        );
        $psr7Worker->respond($res);
    }

    catch (Throwable $e) {
        $psr7Worker->getWorker()->error((string) $e);
    }
}

function phpinfoString(): string
{
    ob_start();
    phpinfo(INFO_ALL);
    $results = ob_get_contents();
    ob_clean();

    return $results;
}