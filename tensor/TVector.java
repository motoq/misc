/*
 c  TVector.java
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

public class TVector extends TMatrix {
  private final double[] vals;

  public TVector(int m) {
    super(m, 1);
    vals = super.valuesPtr();
  }

  public TVector(double[] vec) {
    super(vec.length, 1);
    vals = super.valuesPtr();
    System.arraycopy(vec, 0, vals, 0, vec.length);
  }

  public double get(int ii) {
    return vals[ii];
  }

  public void set(int ii, double value) {
    vals[ii] = value;
  }

  public double ndx(int row) {
    return vals[row-1];
  }

  public void ndx(int row, double value) {
    vals[row-1] = value;
  }
}
