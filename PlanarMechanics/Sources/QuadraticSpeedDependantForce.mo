within PlanarMechanics.Sources;
model QuadraticSpeedDependantForce
  "External force and torque acting at frame_b, defined by 3 input signals and resolved in world frame"

  outer PlanarWorld planarWorld "planar world model";

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA
    resolveInFrame=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.world
    "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_resolve)";
protected
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB  resolveInFrameB= PlanarMechanics.Utilities.Conversions.fromFrameAtoFrameB(resolveInFrame)
    "conversion from frame A to B";

public
  parameter Modelica.SIunits.Force F_nominal
    "Nominal torque (if negative, torque is acting as load)";
  parameter Modelica.SIunits.Velocity v_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  parameter Modelica.SIunits.Torque tau_nominal
    "Nominal torque (if negative, torque is acting as load)";
  parameter Modelica.SIunits.AngularVelocity w_nominal(min=Modelica.Constants.eps)
    "Nominal speed";

 parameter Boolean animation=true "= true, if animation shall be enabled";

   parameter Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
    "Force arrow scaling (length = force/N_to_m)"
    annotation (Dialog(tab="Animation",group="if animation = true", enable=animation));
  parameter Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
    "Torque arrow scaling (length = torque/Nm_to_m)"
    annotation (Dialog(tab="Animation",group="if animation = true", enable=animation));

  input SI.Diameter diameter=planarWorld.defaultArrowDiameter
    "Diameter of force arrow" annotation (Dialog(tab="Animation",group="if animation = true", enable=animation));
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "z position of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation",group="if animation = true", enable=animate));
  input Types.Color color= PlanarMechanics.Types.Defaults.ForceColor
    "Color of arrow"
    annotation (Dialog(tab="Animation",group="if animation = true",colorSelector=true,  enable=animation));
  input Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation",group="if animation = true",enable=animation));

    SI.Force force[3] = worldForce.force;
  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));

  Interfaces.Frame_resolve frame_resolve(fx = 0, fy = 0, t = 0) if resolveInFrameB == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
    "Coordinate system in which vector is optionally resolved, if useExtraFrame is true "
                                                                                            annotation (
      Placement(transformation(extent={{0,-60},{20,-40}}), iconTransformation(
          extent={{-40,-40},{-20,-20}})));

public
  Sensors.AbsoluteVelocity absoluteVelocity(resolveInFrame=resolveInFrame)
    annotation (Placement(transformation(extent={{38,30},{18,50}})));
  WorldForce worldForce(
    animation=animation,
    N_to_m=N_to_m,
    Nm_to_m=Nm_to_m,
    diameter=diameter,
    zPosition=zPosition,
    color=color,
    specularCoefficient=specularCoefficient,
    resolveInFrame=resolveInFrameB)
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Modelica.Blocks.Math.MatrixGain normalizeSpeeds(K=[1/v_nominal,0,0; 0,1/
        v_nominal,0; 0,0,1/w_nominal]) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,40})));
  Modelica.Blocks.Math.MatrixGain scaleForces(K=[-F_nominal,0,0; 0,-F_nominal,0;
        0,0,-tau_nominal])                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,0})));

  Utilities.SquaretimesSign square(blockSize=3) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,40})));
equation
  connect(worldForce.frame_b, frame_b) annotation (Line(
      points={{42,0},{100,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(absoluteVelocity.frame_a, frame_b) annotation (Line(
      points={{38,40},{60,40},{60,0},{100,0}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(worldForce.frame_resolve, frame_resolve) annotation (Line(
      points={{29,-3},{29,-50},{10,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(absoluteVelocity.frame_resolve, frame_resolve) annotation (Line(
      points={{28,30},{28,20},{10,20},{10,-50}},
      color={95,95,95},
      pattern=LinePattern.Dot,
      smooth=Smooth.None));
  connect(absoluteVelocity.v, normalizeSpeeds.u) annotation (Line(
      points={{17,40},{-18,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(square.u, normalizeSpeeds.y) annotation (Line(
      points={{-54,40},{-41,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(square.y, scaleForces.u) annotation (Line(
      points={{-77,40},{-82,40},{-82,0},{-76,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(scaleForces.y, worldForce.force) annotation (Line(
      points={{-53,0},{20,0}},
      color={0,0,127},
      smooth=Smooth.None));
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
          lineColor={0,0,0}),
        Line(
          points={{-100,-100},{-80,-98},{-60,-92},{-40,-82},{-20,-68},{0,-50},{20,
              -28},{40,-2},{60,28},{80,62},{100,100}},
          color={0,0,127}, smooth=Smooth.Bezier)}),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                        graphics),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>Model of a force quadratic dependant on the velocity of the flange. The force can be resolved in a world frame, or a relative speed can be used by selecting resolve_frame to use the extra frame_resolve.</p>
<p>This model is e.g. suitable to simulate aerodynamic drag forces.</p>
</html>"));
end QuadraticSpeedDependantForce;
