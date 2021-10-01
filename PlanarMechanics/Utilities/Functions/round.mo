within PlanarMechanics.Utilities.Functions;
function round "Round to nearest Integer"
  extends Modelica.Icons.Function;

  input Real v "Real number";
  output Integer i "Real number v rounded to nearest integer";

algorithm
  i :=if v >= 0 then integer(floor(v + 0.5)) else integer(ceil(v - 0.5));
  annotation (
    Documentation(
      info="<html>
<p>
Returns the input argument rounded to the nearest Integer. Examples:
</p>
 
<pre>
   round(2.4)  ->  2
   round(2.6)  ->  3
   round(-1.3) -> -1
   round(-1.6) -> -2
</pre>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end round;
