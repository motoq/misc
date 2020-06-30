#include <cstddef>
#include <cstring>

/*
 * Copyright 2020 Kurt Motekew
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */


/**
 * Swaps the endian of the arbitrarily sized input INTEGER data type.
 *
 * @param  val  Input value for which bytes are to be swapped
 *
 * @return  val but with bytes swapped from one endian to the other
 */
template<typename T>
T swap_bytes(T val) noexcept
{
  constexpr size_t nbytes {sizeof(val)};
  char bytes[nbytes];
  std::memcpy(bytes, &val, nbytes);

  val = static_cast<T>(0);
  size_t nbits = static_cast<size_t>(8);
  size_t shift = nbits*(nbytes - static_cast<size_t>(1));
  for (size_t ii=0; ii<nbytes; ++ii) {
    val |= static_cast<T>(0xff & bytes[ii]) << shift;
    shift -= nbits;
  }

  return val;
}


/*
 * Template version of host to network function.  A data dype of any
 * size is taken and all the bytes are swapped.
 *
 * @param  val  Input value that will be swapped from host to network
 *              (big endian) byte order.  No change is made to the
 *              output if this is a big endian system.
 *
 * @return  val  Network bye order (big endian) form of val
 */
template<typename T>
T moa_hton(T val) noexcept
{
  // Return unaltered if already big endian
  if (static_cast<bool>(0xff >> 8)) {
    return val;
  } else {
    return swap_bytes(val);
  }
}


