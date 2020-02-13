#include <iostream>    // KAM

#include <string>
#include <vector>

#include <cog_simstart.h>

bool CogSimStart::valid() const
{
  return valid_state;
}

bool CogSimStart::unserialize(const std::vector<std::string>& tokens)
{
  if (tokens.size() > 0) {
    for(auto& tok : tokens) {
      std::cout << '\n' << tok;
    }
    valid_state = true;
    return true;
  } else {
    valid_state = false;
    return false;
  }
}
  
