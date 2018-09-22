Feature: Entity Context
  In order to use the entity context
  As a Symfony developer
  I need to be able to generate fixtures with ease

  Background:
    Given a Symfony Application
    And the entity "User.php" in "src/Entity":
      """
<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 */
class User
{

    /**
     * @ORM\Column(type="bigint")
     * @ORM\Id
     * @ORM\GeneratedValue
     */
    private $id;

    /**
     * @ORM\Column
     */
    private $login;

    /**
     * @ORM\Column
     */
    private $firstName;

    /**
     * @ORM\Column
     */
    private $lastName;

    /**
     * @ORM\Column
     */
    private $email;

    /**
     * @ORM\OneToMany(targetEntity="Product", mappedBy="user")
     */
    private $products;

    public function getId() { return $id; }
    public function getFirstName() { return $this->firstName; }
    public function getLastName() { return $this->lastName; }
    public function getEmail() { return $this->email; }
    public function getProducts() { return $this->products; }

    public function setFirstName($firstName) { $this->firstName = $firstName; }
    public function setLastName($lastName) { $this->lastName = $lastName; }
    public function setEmail($email) { $this->email = $email; }
    public function setProducts($products) { $this->products = $products; }
}
      """
    And the entity "Product.php" in "src/Entity":
      """
<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 */
class Product
{
    /**
     * @ORM\Column(type="bigint")
     * @ORM\Id
     * @ORM\GeneratedValue
     */
    private $id;

    /**
     * @ORM\Column
     */
    private $name;

    /**
     * @ORM\Column(type="decimal")
     */
    private $price;

    /**
     * @ORM\ManyToOne(targetEntity="User", inversedBy="products")
     */
    private $user;

    public function getId() { return $this->id; }
    public function getName() { return $this->name; }
    public function getPrice() { return $this->price; }
    public function getUser() { return $this->user; }

    public function setName($name) { $this->name = $name; }
    public function setPrice($price) { $this->price = $price; }
    public function setUser($user) { $this->user = $user; }
}
      """
    And the database is up to date

  Scenario: I can create entities with steps
    Given I have the following behat configuration:
      """

      """
    And a file named "features/user.feature" with:
      """

      """
    And a file named "features/product.feature" with:
      """

      """
    When I run "behat --no-colors -f progress"
    Then it should pass with:
      """
      ...

      1 scenario (1 passed)
      3 steps (3 passed)
      """
