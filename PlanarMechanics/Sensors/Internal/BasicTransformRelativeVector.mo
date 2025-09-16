within PlanarMechanics.Sensors.Internal;
model BasicTransformRelativeVector
  "Transform relative vector in to another frame"
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;

  extends Internal.PartialRelativeBaseSensor;

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_in=
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
    "Frame in which vector r_in is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_out=frame_r_in
    "Frame in which vector r_out (= r_in in other frame) is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

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

protected
  Real r_in_0[3] "Input vector resolved in world frame";
  Modelica.Units.SI.Angle phi1_ref "Reference angle 1";
  Modelica.Units.SI.Angle phi2_ref "Reference angle 2";
equation
  if frame_r_out == frame_r_in then
    r_out = r_in;
    phi1_ref = 0;
    phi2_ref = 0;
    r_in_0 = zeros(3);
  else
    r_in_0 = {{cos(phi1_ref),-sin(phi1_ref),0}, {sin(phi1_ref),cos(phi1_ref),0}, {0,0,1}} * r_in;
    r_out = transpose({{cos(phi2_ref),-sin(phi2_ref),0}, {sin(phi2_ref),cos(phi2_ref),0},{0,0,1}}) * r_in_0;

    if frame_r_in == ResolveInFrameAB.world then
      phi1_ref = 0;
    elseif frame_r_in == ResolveInFrameAB.frame_a then
      phi1_ref = frame_a.phi;
    elseif frame_r_in == ResolveInFrameAB.frame_b then
      phi1_ref = frame_b.phi;
    elseif frame_r_in == ResolveInFrameAB.frame_resolve then
      phi1_ref = frame_resolve.phi;
    else
      assert(false, "Wrong value for parameter frame_r_in");
      phi1_ref = 0;
    end if;

    if frame_r_out == ResolveInFrameAB.world then
      phi2_ref = 0;
    elseif frame_r_out == ResolveInFrameAB.frame_a then
      phi2_ref = frame_a.phi;
    elseif frame_r_out == ResolveInFrameAB.frame_b then
      phi2_ref = frame_b.phi;
    elseif frame_r_out == ResolveInFrameAB.frame_resolve then
      phi2_ref = frame_resolve.phi;
    else
      assert(false, "Wrong value for parameter frame_r_out");
      phi2_ref = 0;
    end if;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-128,-92},{-2,-120}},
          textString="r_out"),
        Text(
          extent={{-108,144},{-22,116}},
          textString="r_in"),
        Line(
          points={{0,100},{0,70}},
          color={0,0,127})}));
end BasicTransformRelativeVector;
