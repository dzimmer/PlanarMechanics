within PlanarMechanics.Sources;
model QuadraticSpeedDependentForce
  "External force and torque acting at frame_b, defined by 3 input signals and resolved in world frame"

  outer PlanarWorld planarWorld "Planar world model";

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_resolve)";

public
  parameter SI.Force F_nominal
    "Nominal force (if negative, torque is acting as load)";
  parameter SI.Velocity v_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  parameter SI.Torque tau_nominal
    "Nominal torque (if negative, torque is acting as load)";
  parameter SI.AngularVelocity w_nominal(min=Modelica.Constants.eps)
    "Nominal speed";

  parameter Boolean animation=true "= true, if animation shall be enabled";

  parameter Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
  parameter Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));

  input SI.Diameter diameter=planarWorld.defaultArrowDiameter
    "Has no longer an effect and is only kept for backwards compatibility (arrow visualization by Vector now)"
    annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation",group="If animation = true", enable=animation));
  input MB.Types.Color color= PlanarMechanics.Types.Defaults.ForceColor
    "Color of arrow"
    annotation (HideResult=true, Dialog(tab="Animation",group="If animation = true",colorSelector=true,  enable=animation));
  input MB.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation",group="If animation = true",enable=animation));

  SI.Force force[3] = worldForce.force;

  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  Interfaces.Frame_resolve frame_resolve
    if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
    "Coordinate system in which vector is optionally resolved, if useExtraFrame is true"
    annotation (
      Placement(transformation(extent={{-16,16},{16,-16}},
        rotation=90,
        origin={0,-100})));

public
  Sensors.AbsoluteVelocity absoluteVelocity(
    resolveInFrame =
      if resolveInFrame==MB.Types.ResolveInFrameB.frame_b then MB.Types.ResolveInFrameA.frame_a
      elseif resolveInFrame==MB.Types.ResolveInFrameB.world then MB.Types.ResolveInFrameA.world
      else MB.Types.ResolveInFrameA.frame_resolve)
    annotation (Placement(transformation(extent={{40,30},{20,50}})));
  WorldForce worldForce(
    animation=animation,
    N_to_m=N_to_m,
    Nm_to_m=Nm_to_m,
    zPosition=zPosition,
    color=color,
    specularCoefficient=specularCoefficient,
    resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.MatrixGain normalizeSpeeds(
    K=[1/v_nominal,0,0; 0,1/v_nominal,0; 0,0,1/w_nominal])
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-10,40})));
  Modelica.Blocks.Math.MatrixGain scaleForces(
    K=[F_nominal,0,0; 0,F_nominal,0;0,0,tau_nominal])
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-50,0})));
  Utilities.Blocks.SquaretimesSign square(blockSize=3) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-50,40})));
equation
  connect(worldForce.frame_b, frame_b) annotation (Line(
      points={{40,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteVelocity.frame_a, frame_b) annotation (Line(
      points={{40,40},{60,40},{60,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(worldForce.frame_resolve, frame_resolve) annotation (Line(
      points={{30,-10},{0,-10},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteVelocity.frame_resolve, frame_resolve) annotation (Line(
      points={{30,30},{30,20},{0,20},{0,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(absoluteVelocity.v, normalizeSpeeds.u) annotation (Line(
      points={{19,40},{2,40}},
      color={0,0,127}));
  connect(square.u, normalizeSpeeds.y) annotation (Line(
      points={{-38,40},{-21,40}},
      color={0,0,127}));
  connect(square.y, scaleForces.u) annotation (Line(
      points={{-61,40},{-80,40},{-80,0},{-62,0}},
      color={0,0,127}));
  connect(scaleForces.y, worldForce.force) annotation (Line(
      points={{-39,0},{18,0}},
      color={0,0,127}));

  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Line(
          points={{0,0},{0,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot,
          visible=resolveInFrame==Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve),
        Polygon(
          points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},
              {-100,10}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-100},{-80,-98},{-60,-92},{-40,-82},{-20,-68},{0,-50},{20,
              -28},{40,-2},{60,28},{80,62},{100,100}},
          color={0,0,127}, smooth=Smooth.Bezier),
        Line(
          visible=(resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve),
          points={{0,-10},{0,-100}},
          color={95,95,95},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{72,-24},{108,-49}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(
      info="<html>
<p>
A&nbsp;force applied on <code>frame_b</code> which is quadratic dependent on
the velocity of this frame. Both the measured velocity and the applied force
are resolved in the same frame which is defined via parameter
<code>resolveInFrame</code> as follows:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th>Types.ResolveInFrameA.</th>
    <th>Meaning</th>
  </tr>
  <tr>
    <td>world</td>
    <td>Resolve input force in world frame (= default)</td>
  </tr>
  <tr>
    <td>frame_a</td>
    <td>Resolve input force in frame_b</td>
  </tr>
  <tr>
    <td>frame_resolve</td>
    <td>Resolve input force in frame_resolve (frame_resolve must be connected)</td>
  </tr>
</table>

<p>
This model is e.g. suitable to simulate aerodynamic drag forces.
</p>
</html>",
      revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
end QuadraticSpeedDependentForce;
