#ifndef DEFAULTS_H
#define DEFAULTS_H

/**
 * A class that deomonstrates the effect of explicit construction.
 */
class Defaults {
  public:
   explicit Defaults(int xin, int yin = 0, int zin = 0) : x {xin},
                                                           y {yin},
                                                           z {zin} { }
    int getx() const { return x; }
    int gety() const { return y; }
    int getz() const { return z; }
  private:
    int x {0};
    int y {0};
    int z {0};
};

#endif
