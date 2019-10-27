#include <iostream>
#include <memory>
#include <vector>

#include <ishoot.h>
#include <m14.h>
#include <m14e2.h>

static void shoot_one(IShoot&);
static void shoot_all(std::vector<std::unique_ptr<IShoot>>&);

/**
 * Demonstrates the use of a base class operating on behalf of a
 * derived class.  Also demonstrates storing base classes in a
 * vector allowing for all to be used based on the base class
 * interface.  Demonstrates automatic release of memory when
 * the vector storing unique pointers goes out of scope and
 * handling of unique pointers.
 *
 * Notice:
 *   When adding a unique_ptr to a container, if created outside
 *   the call to push/emplace_back, std::move must be used.
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

  // unique_ptr will deallocate upon exit of scope
  std::cout << "\n\nShooting using list of unique_ptr with new IShoot'ers";
  {
    std::vector<std::unique_ptr<IShoot>> shooters;
    std::unique_ptr<IShoot> up = nullptr;

    up =  std::make_unique<M14E2>("First");
    shooters.push_back(std::move(up));
    // Nope - runtime seg fault - up no longer points to anything:
    //   up->fire();

    up =  std::make_unique<M14>("Second - never used");
    // Nope - compile time error - can't change ownership through
    // pointer copy:
    //   std::unique_ptr<IShoot> up2 = up;

    up =  std::make_unique<M14>("Third");
    shooters.push_back(std::move(up));

    up =  std::make_unique<M14E2>("Fourth");
    shooters.push_back(std::move(up));

    shoot_all(shooters);
    std::cout << "\nAbout to exit unique_ptr block";
  }
  std::cout << "\nJust left unique_ptr block";

  // Take note of when local variables call their destructors
  std::cout << "\n\nLast statement in program - about to \"return 0;\"\n";
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

