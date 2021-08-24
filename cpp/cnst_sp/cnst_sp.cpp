#include <iostream>
#include <memory>

/**
 * Illustrates use of const when passing a shared pointer
 * along with use_count changes when passing around.
 */


// Just an integer wrapper class
class IntWpr {
public:
  IntWpr() {}
  IntWpr(int newval) { val = newval; }

  int getInt() const {return val; }
  void setInt(int newval) { val = newval; }

private:
  int val;
};

// A class that retains an externally created shared_ptr
class IntPtr {
public:
  IntPtr(const std::shared_ptr<const IntWpr>& in)
  {
    std::cout << "\nEntered IntPtr Constructor: " << in.use_count();
    iPtr = in;
    std::cout << "\nInput count after local assignment: " << in.use_count();
    std::cout << "\nLocal count after assignment:       " << iPtr.use_count();
    std::cout << "\nExiting IntPtr Constructor";

    //in = std::make_shared<IntWpr>(10);              // Nope!
    //in->setInt(10);                                 // Nope!
  }

  int getCount() const
  {
     //iPtr->setInt(10);                              // Nope
     return iPtr.use_count();
  }

private:
  std::shared_ptr<const IntWpr> iPtr;
};

void print_csp(const std::shared_ptr<IntWpr>& in);
void print_spc(std::shared_ptr<const IntWpr> in);


int main() {
  auto foo = std::make_shared<IntWpr>(10);
  std::cout << "\nCount after init: " << foo.use_count();
  
  std::cout << "\n\nPassing by const reference and modifying contents";
  print_csp(foo);
  std::cout << "\nContents after exiting function: " << foo->getInt();

  std::cout << "\n\nPassing by value not using const";
  print_spc(foo);
  std::cout << "\nContents after exiting function: " << foo->getInt();

  std::cout << "\n\nCurrent use count: " << foo.use_count();
  IntPtr rc(foo);
  std::cout << "\nAfter instantiation: " << foo.use_count();
  std::cout << "\nAfter instantiation: " << rc.getCount();

  auto rc2 = rc;
  std::cout << "\n\nAfter copying class: " << rc.getCount();
  std::cout << "\nAfter copying class: " << rc2.getCount();

  std::cout << '\n';
}


// Able to modify contents of what is pointed to, but
// can't modify what is pointed to.
void print_csp(const std::shared_ptr<IntWpr>& in)
{
  std::cout << "\nBefore Changing value: " << in->getInt();
  in->setInt(7);
  std::cout << "\nAfter Changing value: " << in->getInt();

  //in = std::make_shared<IntWpr>(10);                // Error
}

// Can reassign pointer, but can't modify contents to what was passed in
void print_spc(std::shared_ptr<const IntWpr> in)
{
  //in->setInt(5);                                    // Error

  std::cout << "\nEntering function with: " << in->getInt();
  in = std::make_shared<IntWpr>(10);
  std::cout << "\nAfter reassignment in function: " << in->getInt();
}

