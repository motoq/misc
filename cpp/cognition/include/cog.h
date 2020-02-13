#ifndef COG_H
#define COG_H

#include <string>
#include <vector>

/**
 * Interface for objects defining a component to the simulation
 * environment.
 */
class Cog {
  public:
    virtual ~Cog() = default;

    /**
     * @return  If true, the class is valid.  An invalid class could be
     *          the result of an attempt to unserialize with bad data.
     */
    virtual bool valid() const = 0;

    /**
     * Create cog given a tokenized text description.
     *
     * @param  tokens  Text values to convert to a cog.
     */
    virtual bool unserialize(const std::vector<std::string>& tokens) = 0;
};

#endif  // COG_H
