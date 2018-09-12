within PlanarMechanics.Sensors;
model TransformRelativeVector "Transform relative vector in to another frame"
  extends Internal.PartialRelativeSensor;

  Interfaces.Frame_resolve frame_resolve if
   (frame_r_in  == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) or
   (frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    "Coordinate system in which r_in or r_out is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}}),
        iconTransformation(extent={{84,65},{116,97}})));

  Modelica.Blocks.Interfaces.RealInput r_in[3]
    "Input vector resolved in frame defined by frame_r_in"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput r_out[3]
    "Input vector r_in resolved in frame defined by frame_r_out"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_in=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which vector r_in is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_out=
                  frame_r_in
    "Frame in which vector r_in shall be resolved and provided as r_out (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

protected
  Internal.BasicTransformRelativeVector
    basicTransformVector(
      frame_r_in=frame_r_in,
      frame_r_out=frame_r_out)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Interfaces.ZeroPosition zeroPosition if
    not (frame_r_in == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve or
         frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));

equation
  connect(basicTransformVector.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-32.5,0},{-32.5,0},{-55,0},
          {-55,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicTransformVector.frame_b, frame_b) annotation (Line(
      points={{10,0},{32.5,0},{32.5,0},{55,0},
          {55,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(basicTransformVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,8.1},{30,8.1},{30,80},{100,80}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicTransformVector.frame_resolve)
    annotation (Line(
      points={{40,30},{30,30},{30,8.1},{10,8.1}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(basicTransformVector.r_out, r_out) annotation (Line(
      points={{0,-11},{0,-35.75},{0,-35.75},{0,
          -60.5},{0,-60.5},{0,-110}},
      color={0,0,127}));
  connect(basicTransformVector.r_in, r_in) annotation (Line(
      points={{0,12},{0,39},{0,39},{0,
          66},{0,66},{0,120}},
      color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Line(
          points={{0,100},{0,70}},
          color={0,0,127}),
        Text(
          extent={{-104,124},{-18,96}},
          textString="r_in"),
        Text(
          extent={{-124,-76},{2,-104}},
          textString="r_out")}),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2018 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>
The input vector \"Real r_in[3]\" is assumed to be a relative kinematic quantity
between frame_a and frame_b
that is defined to be resolved in the frame defined
with parameter \"frame_r_in\". This model resolves vector r_in in the
coordinate system defined with parameter \"frame_r_out\" and returns the
transformed output vector as \"Real r_out[3]\";
</p>
</html>"));
end TransformRelativeVector;
