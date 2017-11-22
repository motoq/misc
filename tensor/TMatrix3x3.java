/*
 c  TMatrix3x3.java
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

public class TMatrix3x3 extends TMatrix {

  public TMatrix3x3() {
    super(3, 3);
  }

  public TMatrix3x3(double[][] mtrx) {
    super(3, 3);
    for (int ii=0; ii<3; ii++) {
      for (int jj=0; jj<3; jj++) {
        set(ii, jj, mtrx[ii][jj]);
      }
    }
  }

  public double get(Basis3D row, Basis3D col) {
    return super.get(row.ordinal(), col.ordinal());
  }

  public void set(Basis3D row, Basis3D col, double value) {
    super.set(row.ordinal(), col.ordinal(), value);
  }

}
