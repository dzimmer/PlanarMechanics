within PlanarMechanics.VehicleComponents;
package Wheels "Wheel and tire models"
  extends Modelica.Icons.Package;


  annotation (
    Documentation(
      info="<html>
<p>This package contains wheel models that roll on the x,y plane. The wheel models are hereby represented as a mass-free element similar to a joint component.</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<b>Developed 2010-2019 at the DLR Institute of System Dynamics and Control</b>
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics={
      Ellipse(
        extent={{-70,70},{70,-70}},
        fillColor={215,215,215},
        fillPattern=FillPattern.Sphere),
      Ellipse(
        extent={{-50,50},{50,-50}},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None),
      Ellipse(
        extent={{-10,10},{10,-10}},
        lineColor={0,0,255},
        fillPattern=FillPattern.Solid)}));
end Wheels;
