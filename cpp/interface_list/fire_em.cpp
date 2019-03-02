#include <iostream>
#include <memory>
#include <vector>

#include <ishoot.h>
#include <m14.h>
#include <m14e2.h>

static void shoot_one(IShoot&);
static void shoot_all(std::vector<std::unique_ptr<IShoot>>&);
static void shoot_all_sp(std::vector<std::shared_ptr<IShoot>>&);
static void shoot_all_p(std::vector<IShoot*>& shooter_lst);

int main()
{

  // Put each in a function to see deallocation
  // Must make destructors



  M14 m14;
  M14E2 m14e2;

  std::cout << "\nShooting from object in main";
  m14.fire();
  m14e2.fire();

  std::cout << "\n\nShooting from function with reference";
  {
    shoot_one(m14);
    shoot_one(m14e2);
  }

  //
  // Core dump:  An attempt to deallocate m14 and m14e2
  // after shooters_bad goes out of scope because of connection
  // with unique_ptr.
  //
/*
  {
    std::vector<std::unique_ptr<IShoot>> shooters_bad;
    shooters_bad.emplace_back(&m14);
    shooters_bad.emplace_back(&m14e2);
    shoot_all(shooters_bad);
    std::cout << "\nAbout to core dump with unique_ptr...";
  }
*/

  //
  // Core dump:  Same problem as with unique_ptr since only
  // custodian of m14 and m14e2
  //
/*
  {
    std::vector<std::shared_ptr<IShoot>> shooters_bad;
    shooters_bad.emplace_back(&m14);
    shooters_bad.emplace_back(&m14e2);
    shoot_all_sp(shooters_bad);
    std::cout << "\nAbout to core dump with shared_ptr...";
  }
*/

  std::cout << "\n\nShooting from pointer in main";
  {
    IShoot* sp = &m14;
    sp->fire();
    sp = &m14e2;
    sp->fire();
  }

    // Note filling list with objects on heap
    // unique_ptr will deallocate upon exit of scope
  std::cout << "\n\nShooting using list of unique_ptr with new IShoot'ers";
  {
    std::vector<std::unique_ptr<IShoot>> shooters;
    shooters.emplace_back(new M14);
    shooters.emplace_back(new M14E2);
    shoot_all(shooters);
    std::cout << "\nAbout to exit unique_ptr block";

    // OK:  std::unique_ptr<IShoot> up_m14e2 = std::make_unique<M14E2>();
    // BAD: shooters.emplace_back(up_m14e2);
  }
    std::cout << "\nJust left unique_ptr block";

    // Note filling list with objects on heap
  std::cout << "\n\nShooting using list of shared_ptr with new IShoot'ers";
    // This one gets destroyed before program exit
  std::shared_ptr<IShoot> sp_m14 = std::make_shared<M14>();
  //std::shared_ptr<IShoot> sp_m14e2 (new M14E2);
    // This one gets destroyed when exiting block
  M14E2* sp_m14e2 = new M14E2;  // Deallocated after exiting block
  {
    std::vector<std::shared_ptr<IShoot>> shooters_shared;
    shooters_shared.emplace_back(sp_m14);
    shooters_shared.emplace_back(sp_m14e2);
    shoot_all_sp(shooters_shared);
    std::cout << "\nAbout to exit shared_ptr block";
  }
    std::cout << "\nJust left shared_ptr block";

    // Standard pointer - won't free memory until program
    // Exits.  Note the Destructor text occurs after the
    // newline printed below
  std::cout << "\n\nShooting using pointers just allocated and not freed";
  std::cout << "\nNote that newline issued just before return";
  std::cout << "\nbut destructor called after newline (after program exit)";
  std::vector<IShoot*> shooters_p;
  shooters_p.emplace_back(new M14);
  shooters_p.emplace_back(new M14E2);
  shoot_all_p(shooters_p);

  std::cout << '\n';

  return 0;
}

static void shoot_one(IShoot& shooter)
{
  shooter.fire();
}

static void shoot_all(std::vector<std::unique_ptr<IShoot>>& shooter_lst)
{
  unsigned int n = static_cast<unsigned int>(shooter_lst.size());
  for (unsigned int ii=0;  ii<n; ++ii) {
    shooter_lst[ii]->fire();
  }
}

static void shoot_all_sp(std::vector<std::shared_ptr<IShoot>>& shooter_lst)
{
  unsigned int n = static_cast<unsigned int>(shooter_lst.size());
  for (unsigned int ii=0;  ii<n; ++ii) {
    shooter_lst[ii]->fire();
  }
}

static void shoot_all_p(std::vector<IShoot*>& shooter_lst)
{
  unsigned int n = static_cast<unsigned int>(shooter_lst.size());
  for (unsigned int ii=0;  ii<n; ++ii) {
    shooter_lst[ii]->fire();
  }
}

