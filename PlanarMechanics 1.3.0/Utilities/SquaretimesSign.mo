within PlanarMechanics.Utilities;
block SquaretimesSign
  "Output the product of a gain matrix with the input signal vector"
// extends Modelica.Blocks.Interfaces.MIMO(final nin=size(u, 2), final nout=size(
//          u, 2));
//  parameter Real K[:, :]=[1, 0; 0, 1]
 //   "Gain matrix which is multiplied with the input";
//  extends Modelica.Blocks.Interfaces.MIMO(final nin=size(K, 1), final nout=size(
//         K, 1));
parameter Integer blockSize;
extends Modelica.Blocks.Interfaces.MIMO(final nin=blockSize, final nout=blockSize);
equation
  for i in 1:size(u,1) loop
  y[i] = smooth(1,u[i]^2*sign(u[i]));
  end for;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output vector <b>y</b> as <i>product</i> of the
gain matrix <b>K</b> with the input signal vector <b>u</b>:
</p>
<pre>
    <b>y</b> = <b>K</b> * <b>u</b>;
</pre>
<p>
Example:
</p>
<pre>
   parameter: <b>K</b> = [0.12 2; 3 1.5]

   results in the following equations:

     | y[1] |     | 0.12  2.00 |   | u[1] |
     |      |  =  |            | * |      |
     | y[2] |     | 3.00  1.50 |   | u[2] |
</pre>

</html>"), Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={Text(
      extent={{-90,-60},{90,60}},
      lineColor={160,160,164},
          textString="K^*sign"),
                        Text(
      extent={{-150,150},{150,110}},
      textString="%name",
      lineColor={0,0,255})}),
    Diagram(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={Rectangle(
      extent={{-100,-100},{100,100}},
      lineColor={0,0,255},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid), Text(
      extent={{-90,-60},{90,60}},
      lineColor={160,160,164},
          textString="K^*sign")}));
end SquaretimesSign;
