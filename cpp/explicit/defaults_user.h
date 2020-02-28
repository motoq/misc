#ifndef DEFAULTS_USER_H
#define DEFAULTS_USER_H

#include <defaults.h>

/**
 * A class to deomonstrate the effect of explicit construction on a
 * class that takes a single object (vs. intrinsic) as an argument.
 */
class DefaultsUser {
  public:
    explicit DefaultsUser(const Defaults& d) : def {d} {}
    int getx() const { return def.getx(); }
    int gety() const { return def.gety(); }
    int getz() const { return def.getz(); }
  private:
    Defaults def;
};

#endif
