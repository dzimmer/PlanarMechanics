within PlanarMechanics.VehicleComponents.Examples;
model TestIdealWheel
  extends Modelica.Icons.Example;

  VehicleComponents.Wheels.IdealWheelJoint idealWheelJoint(
    radius=0.3,
    r={1,0},
    animate=true)
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,28})));
  Joints.Prismatic prismatic(
    r={0,1}, s(start=1, fixed=true))
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-2})));
  Joints.Revolute revolute(
    phi(fixed=true),
    w(fixed=false),
    stateSelect=StateSelect.always)
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-32})));
  Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-62})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque engineTorque(
      tau_constant=2)
    annotation (Placement(transformation(extent={{-32,58},{-12,78}})));
  Parts.Body body(m=10, I=1,
    animate=false)
    annotation (Placement(transformation(extent={{20,-2},{40,18}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    J=1)                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,58})));
  inner PlanarWorld planarWorld(enableAnimation=true, g={0,0})
    annotation (Placement(transformation(extent={{-80,-12},{-60,8}})));
equation
  connect(idealWheelJoint.frame_a, prismatic.frame_b) annotation (Line(
      points={{1.50184e-016,23.2},{1.50184e-016,26.6},{1.05639e-015,26.6},{
          1.05639e-015,8}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(prismatic.frame_a, revolute.frame_b) annotation (Line(
      points={{-1.68214e-016,-12},{1.05639e-015,-12},{1.05639e-015,-22}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_a, fixed.frame_a) annotation (Line(
      points={{-1.68214e-016,-42},{2.50304e-015,-42},{2.50304e-015,-52}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(engineTorque.flange, inertia.flange_a) annotation (Line(
      points={{-12,68},{2.33651e-015,68}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inertia.flange_b, idealWheelJoint.flange_a) annotation (Line(
      points={{-1.33731e-015,48},{0,40},{1.1119e-015,38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(body.frame_a, prismatic.frame_b) annotation (Line(
      points={{20,8},{1.05639e-015,8}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p><h4><font color=\"#008000\">This is an ideal wheel. </font></h4></p>
<p>It introduces one non-holonomic constraint. Difficult for index-reduction.</p>
<p><img src=\"modelica://PlanarMechanics/Resources/Images/TestIdealWheel_1.png\"/></p>
<p><br/><br/><img src=\"modelica://PlanarMechanics/Resources/Images/TestIdealWheel_2.png\"/></p>
<p>SELECTED&nbsp;CONTINUOUS&nbsp;TIME&nbsp;STATES</p>
<p>&nbsp;&nbsp;inertia.phi</p>
<p>&nbsp;&nbsp;prismatic.s</p>
<p>&nbsp;&nbsp;revolute.phi</p>
<p>&nbsp;&nbsp;revolute.w</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was created and is owned by Dr. Dirk Zimmer.</p>
<p>dirk.zimmer@dlr.de</p>
</html>"),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput);
end TestIdealWheel;
