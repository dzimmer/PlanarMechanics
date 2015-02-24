within PlanarMechanics.Examples;
model FreeBody "A simple free falling body"
  extends Modelica.Icons.Example;

  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Parts.Body body(m=1, I=0.1,
    animate=true,
    a(each fixed=false),
    r(each fixed=true),
    v(each fixed=true),
    phi(fixed=true),
    w(fixed=true))
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  inner MB.World world
    annotation (Placement(transformation(extent={{-30,34},{-10,54}})));
  annotation (
    experiment(StopTime=3),
    Documentation(revisions="<html>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",
      info="<html>
<p>The gravity is defined in the planarWorld component</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/FreeBody_1.png\"/></p>
<p>The DAE has 73&nbsp;scalar unknowns and 73&nbsp;scalar equations.</p>
</html>"));
end FreeBody;
