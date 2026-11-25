Action	What you need to do
Create a new entity	Create an @Entity class
Create its repository	Extend JpaRepository<Entity, ID>
Standard CRUD	Already implemented
Add custom queries	Declare methods such as findByNom()
Register new entity	Add it to persistence.xml
Build and deploy	Run bash deploy.sh