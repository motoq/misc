/*
 c  TVector3D.java
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

public class TVector3D extends TVector {

  public TVector3D() {
    super(3);
  }

  public TVector3D(double[] vec) {
    super(3);
    for (int ii=0; ii<3; ii++) {
      set(ii, vec[ii]);
    }
  }

  public double get(Basis3D ii) { return super.get(ii.ordinal()); }

  public void set(Basis3D ii, double value) { super.set(ii.ordinal(), value); }

}
