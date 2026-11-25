``` php

// Controller
<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\FormationModel;

class FormationsAPI extends BaseController
{
    public function formations()
    {
        $formations = model(FormationModel::class)->findAll();
        $this->response->setStatusCode(200)->setJSON(["yay" => "you landed here "]);

    }
}
```

``` php
// model
    <?php

namespace App\Models;

use CodeIgniter\Model;

class FormationModel extends Model
{
    protected $table         = 'formations';
    protected $primaryKey    = 'id';
    protected $returnType    = 'array';
    protected $allowedFields = ['titre', 'description', 'niveau'];

}
```

``` sql
-- sql
-- Données communes aux 4 versions
CREATE TABLE IF NOT EXISTS formations (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    titre       TEXT    NOT NULL,
    description TEXT    NOT NULL,
    niveau      TEXT    NOT NULL
);

INSERT INTO formations (titre, description, niveau) VALUES
 ('Algorithmique',        'Structures de contrôle, tableaux, complexité.',        'L1'),
 ('Bases de données',     'Modèle relationnel, SQL, normalisation.',              'L1'),
 ('Développement web',    'HTML, CSS, PHP et échanges client-serveur.',           'L2'),
 ('Réseaux',              'Modèle TCP/IP, adressage, services réseau.',           'L2'),
 ('Développement mobile', 'Applications Android, consommation d''API.',           'L3'),
 ('Architecture logicielle', 'Couches, API REST, séparation front / back.',      'L3');


```

``` php
// routes
    <?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->get('api/formations', 'Api\FormationsAPI::formations');
$routes->get('api/formations/(:num)', 'Api\FormationsAPI::formationById/$1');

```