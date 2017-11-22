/*
 c  Tensor.java
 c
 c  Copyright (C) 2017 Kurt Motekew
 c
 c  This library is free software; you can redistribute it and/or
 c  modify it under the terms of the GNU Lesser General Public
 c  License as published by the Free Software Foundation; either
 c  version 2.1 of the License, or (at your option) any later version.
 c
 c  This library is distributed in the hope that it will be useful,
 c  but WITHOUT ANY WARRANTY; without even the implied warranty of
 c  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 c  Lesser General Public License for more details.
 c
 c  You should have received a copy of the GNU Lesser General Public
 c  License along with this library; if not, write to the Free Software
 c  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 c  02110-1301 USA
 */

import java.util.Arrays;

public class Tensor {
  private final int SIZE;
  private final int RANK;
  private final double[] vals;

  public Tensor(int dimension) {
    RANK = 1;
    SIZE = dimension;
    vals = new double[SIZE];
  }

  public Tensor(int rows, int cols) {
    RANK = 2;
    SIZE = rows*cols;
    vals = new double[SIZE];
  }

  /** @return   The rank of the tensor */
  public int rank() { return RANK; }
  
  /** @return   The total number of elements composing the tensor */
  public int size() { return SIZE; }
  
  public void zero() {
    Arrays.fill(vals, 0.0);
  }

  public void mult(double num) {
    for (int ii=0; ii<SIZE; ii++) {
      vals[ii] *= num;
    }
  }

  double [] valuesPtr() {
    return vals;
  }
}
