<?php

namespace App\Controllers;

class Patient extends BaseController
{
    public function show($id)
    {
        $apiBaseUrl = rtrim((string) env('PATIENT_API_BASE_URL', ''), '/');

        if ($apiBaseUrl === '') {

            return $this->response->setStatusCode(500) ->setBody('API URL is not configured.');
        }

        // Build the API endpoint using the same ID
        $url = $apiBaseUrl . '?' . 'id=' . $id;

        try {
            $client = service('curlrequest');

            $response = $client->get($url, [
                'timeout' => 5,
                'http_errors' => false,
                'headers' => [
                    'Accept' => 'application/json'
                ]
            ]);

            // Handle patient not found
            if ($response->getStatusCode() === 404) {
                return $this->response
                    ->setStatusCode(404)
                    ->setBody('Patient not found.');
            }

            // Handle other API errors
            if ($response->getStatusCode() !== 200) {
                return $this->response
                    ->setStatusCode(502)
                    ->setBody('Unable to retrieve patient information.');
            }

            // Convert JSON into a PHP array
            $patient = json_decode($response->getBody(),true);

            // Validate the API response
            if (
                !is_array($patient) ||
                !isset(
                    $patient['id'],
                    $patient['nom'],
                    $patient['prenom'],
                    $patient['date_naissance']
                )
            ) {
                return $this->response
                    ->setStatusCode(502)
                    ->setBody('Invalid patient data received.');
            }

            // Display the patient page
            return view('patient/show', [
                'patient' => $patient
            ]);

        } catch (\Throwable $e) {

            log_message('error', 'Patient API error: ' . $e->getMessage());

            return $this->response
                ->setStatusCode(502)
                ->setBody('The patient service is unavailable.');
        }
    }
}