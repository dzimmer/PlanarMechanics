within PlanarMechanics.Sensors.Internal;
model BasicTransformAbsoluteVector
  "Transform absolute vector in to another frame"
  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types.ResolveInFrameA;

  extends Modelica.Icons.RotationalSensor;

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_in=
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a
    "Frame in which vector r_in is resolved (1: world, 2: frame_a, 3: frame_resolve)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameA frame_r_out=
                  frame_r_in
    "Frame in which vector r_out (= r_in in other frame) is resolved (1: world, 2: frame_a, 3: frame_resolve)";

  Interfaces.Frame_a frame_a
    "Coordinate system from which absolute kinematic quantities are measured"            annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

  Interfaces.Frame_resolve frame_resolve
    "Coordinate system in which vector is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        origin={100,0}),
        iconTransformation(extent={{-16,-16},{16,16}},
        origin={100,0})));

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
  Real R1[3,4]
    "Orientation object from frame in which r_in is resolved to world frame";
  Real r_temp[3] "Temporary vector in transformation calculation";
equation
   assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
   assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
   frame_a.fx = 0;
   frame_a.fy = 0;
   frame_a.t = 0;
   frame_resolve.fx = 0;
   frame_resolve.fy = 0;
   frame_resolve.t = 0;

   r_temp = R1 * {r_in[1],r_in[2],r_in[3],1};
   if frame_r_out == frame_r_in then
      r_out = r_in;
      R1 = {{cos(0),-sin(0),0,0},{sin(0),cos(0),0,0},{0,0,1,0}};
   else
      if frame_r_in == ResolveInFrameA.world then
         R1 = {{cos(0), -sin(0),0,0}, {sin(0),cos(0),0,0}, {0,0,1,0}};
      elseif frame_r_in == ResolveInFrameA.frame_a then
         R1 = {{cos(frame_a.phi), -sin(frame_a.phi),0,0}, {sin(frame_a.phi),cos(frame_a.phi),0,0},{0,0,1,frame_a.phi}};
      elseif frame_r_in == ResolveInFrameA.frame_resolve then
         R1 = {{cos(frame_resolve.phi), -sin(frame_resolve.phi),0,0}, {sin(frame_resolve.phi),cos(frame_resolve.phi),0,0},{0,0,1,frame_resolve.phi}};
      else
         assert(false, "Wrong value for parameter frame_r_in");
         R1 = {{cos(0),-sin(0),0,0},{sin(0),cos(0),0,0},{0,0,1,0}};
      end if;

      if frame_r_out == ResolveInFrameA.world then
         r_out = r_temp;
      elseif frame_r_out == ResolveInFrameA.frame_a then
         r_out = {{cos(frame_a.phi), sin(frame_a.phi),0}, {-sin(frame_a.phi),cos(frame_a.phi),0},{0,0,1}} * {r_temp[1],r_temp[2],r_temp[3]};
      elseif frame_r_out == ResolveInFrameA.frame_resolve then
         r_out = {{cos(frame_resolve.phi), sin(frame_resolve.phi),0}, {-sin(frame_resolve.phi),cos(frame_resolve.phi),0},{0,0,1}} * {r_temp[1],r_temp[2],r_temp[3]};
      else
         assert(false, "Wrong value for parameter frame_r_out");
         r_out = zeros(3);
      end if;
   end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}},
        grid={1,1}), graphics={
        Text(
          extent={{-128,-84},{-2,-112}},
          textString="r_out"),
        Text(
          extent={{-108,137},{-22,109}},
          textString="r_in"),
        Line(
          points={{0,100},{0,70}},
          color={0,0,127}),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Text(
          extent={{58,47},{189,22}},
          lineColor={95,95,95},
          textString="resolve"),
        Text(
          extent={{-116,45},{-80,20}},
          lineColor={95,95,95},
          textString="a"),
        Line(
          points={{-70,0},{-96,0},{-96,0}}),
        Line(
          points={{95,0},{95,0},{70,0},{70,0}},
          pattern=LinePattern.Dot)}));
end BasicTransformAbsoluteVector;
