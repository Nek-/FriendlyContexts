<?php

namespace Knp\FriendlyContexts\DependencyInjection\Compiler;

use Symfony\Component\DependencyInjection\Compiler\CompilerPassInterface;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class ConfigPass implements CompilerPassInterface
{
    public function process(ContainerBuilder $container)
    {
        $parameters = [];
        $this->buildParameters('friendly', $parameters, $container->getParameter('friendly.parameters'));

        foreach ($parameters as $key => $value) {
            $container->setParameter($key, $value);
        }
    }

    /**
     * @param string $name
     * @param array  $parameters
     * @param array  $config
     */
    protected function buildParameters($name, &$parameters, $config)
    {
        foreach ($config as $key => $element) {
            if (is_array($element) && $this->arrayHasStringKeys($element)) {
                $this->buildParameters(sprintf('%s.%s', $name, $key), $parameters, $element);
            }
            $parameters[sprintf('%s.%s', $name, $key)] = $element;
        }

        if (!empty($parameters['friendly.smartTag'])) {
           if ($parameters['friendly.smartStep.tagName'] === 'smartStep') {
               $parameters['friendly.smartStep.tagName'] = $parameters['friendly.smartTag'];
           }

           // TODO: trigger deprecation error
        }
    }

    protected function arrayHasStringKeys(array $array)
    {
        foreach ($array as $key => $value) {
            if (is_string($key)) {

                return true;
            }
        }

        return false;
    }
}
