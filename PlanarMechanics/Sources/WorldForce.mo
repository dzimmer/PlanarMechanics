within PlanarMechanics.Sources;
model WorldForce
  "External force and torque acting at frame_b, defined by 3 input signals and resolved in world frame"

  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  Modelica.Blocks.Interfaces.RealInput force[3]
    "x-, y-coordinates of force and torque resolved in world frame"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

equation
  {frame_b.fx,frame_b.fy} + {force[1], force[2]} = {0, 0};
  frame_b.t +  force[3]= 0;

  annotation (Icon(graphics={
        Polygon(
          points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},
              {-100,10}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-40},{100,-80}},
          textString="%name",
          lineColor={0,0,0})}), Diagram(graphics),
    Documentation(revisions="<html><p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>The <b>3</b> signals of the <b>force</b> connector contain force and torque. The first and second signal are interpreted as the x- and y-coordinates of a <b>force</b> and the third is torque, acting at the frame connector to which <b>frame_b</b> of this component is attached. Note that torque is a scalar quantity, which is exerted perpendicular to the x-y plane.</p>
<p>An example of this model is given in the following figure:</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/WorldForce.png\"/></p>
</html>"));
end WorldForce;
