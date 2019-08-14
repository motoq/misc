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

/**
 * The use of shared and unique pointers is demonstrated along
 * With creating a <vector> of objects derived from the same base
 * class (interface).  Pointers must be used to do this.  The
 * use of unique_ptr allows all allocated objects within the vector
 * to be deallocated automatically once the vector goes out of scope
 * vs. looping through the <vector> and deleting each object.
 *
 * Notice:
 *  emplace_back vs. push_back
 *  make_shared vs. new
 *  make_unique vs. new
 *    When adding a unique_ptr to a container, it must be created
 *    during the call to emplace_back.  It can not be called,
 *    pointing to a local variable, with that local variable being
 *    added to the container.  Use a shared_ptr for that.
 */
int main()
{
  M14 m14("local instantiation");
  M14E2 m14e2("local instantiation");

  std::cout << "\nShooting from object in main";
  m14.fire();
  m14e2.fire();

  std::cout << "\n\nShooting from function with reference";
  {
    shoot_one(m14);
    shoot_one(m14e2);
  }

  // Core dump:  An attempt to deallocate m14 and m14e2
  // after shooters_bad goes out of scope because of connection
  // with unique_ptr.
  /*
  {
    std::vector<std::unique_ptr<IShoot>> shooters_bad;
    shooters_bad.emplace_back(&m14);
    shooters_bad.emplace_back(&m14e2);
    shoot_all(shooters_bad);
    std::cout << "\nAbout to core dump with unique_ptr...";
  }
  */

  // Core dump:  Same problem as with unique_ptr since only
  // custodian of m14 and m14e2
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

    // unique_ptr will deallocate upon exit of scope
  std::cout << "\n\nShooting using list of unique_ptr with new IShoot'ers";
  {
    std::vector<std::unique_ptr<IShoot>> shooters;
    shooters.emplace_back(new M14);
    shooters.emplace_back(new M14E2);
    shooters.emplace_back(std::make_unique<M14E2>("make_unique"));
    shooters.push_back(std::make_unique<M14E2>("make_unique push_back"));
    shoot_all(shooters);
    std::cout << "\nAbout to exit unique_ptr block";
     //*OK:*/  std::unique_ptr<IShoot> up_m14e2 = std::make_unique<M14E2>();
     //*BAD:*/ shooters.emplace_back(up_m14e2);
  }
  std::cout << "\nJust left unique_ptr block";

    // Storing shared_ptr via make_shared, new shared_ptr, new pointer
  std::cout << "\n\nShooting using list of shared_ptr with new IShoot'ers";
  {
    std::shared_ptr<IShoot> sp_m14 = std::make_shared<M14>("make_shared");
    std::shared_ptr<IShoot> sp_m14e2 (new M14E2("new shared_ptr"));
    M14E2* p_m14e2 = new M14E2("new pointer");
    std::vector<std::shared_ptr<IShoot>> shooters_shared;
    shooters_shared.emplace_back(sp_m14);
    shooters_shared.emplace_back(sp_m14e2);
    shooters_shared.emplace_back(p_m14e2);
    shoot_all_sp(shooters_shared);
    std::cout << "\nAbout to exit shared_ptr block";
  }
  std::cout << "\nJust left shared_ptr block";

    // Standard pointer and no deallocation performed
    // Destructors not called before program exit
  std::cout << "\n\nShooting using list of pointers with new IShoot'ers";
  std::vector<IShoot*> shooters_p;
  shooters_p.emplace_back(new M14("pointer"));
  shooters_p.emplace_back(new M14E2("pointer"));
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

