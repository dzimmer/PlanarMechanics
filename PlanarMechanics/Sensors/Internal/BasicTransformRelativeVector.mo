within PlanarMechanics.Sensors.Internal;
model BasicTransformRelativeVector
  "Transform relative vector in to another frame"
  import Modelica.Mechanics.MultiBody.Frames;
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

// protected
//   Modelica.Mechanics.MultiBody.Frames.Orientation R1
//     "Orientation object from world frame to frame in which r_in is resolved";
  Real R1[3,3];

equation
   if frame_r_out == frame_r_in then
      r_out = r_in;
      //R1 = Frames.nullRotation();
      R1 = {{cos(0), -sin(0), 0}, {sin(0),cos(0), 0}, {0,0,1}};
   else
      if frame_r_in == ResolveInFrameAB.world then
         R1 = {{cos(0), -sin(0), 0}, {sin(0),cos(0), 0}, {0,0,1}};
      elseif frame_r_in == ResolveInFrameAB.frame_a then
         R1 = {{cos(frame_a.phi), -sin(frame_a.phi), 0}, {sin(frame_a.phi),cos(frame_a.phi),0},{0,0,1}};
      elseif frame_r_in == ResolveInFrameAB.frame_b then
         R1 = {{cos(frame_b.phi), -sin(frame_b.phi),0}, {sin(frame_b.phi),cos(frame_b.phi),0},{0,0,1}};
      else
         R1 = {{cos(frame_resolve.phi), -sin(frame_resolve.phi),0}, {sin(frame_resolve.phi),cos(frame_resolve.phi),0},{0,0,1}};
      end if;

      if frame_r_out == ResolveInFrameAB.world then
         r_out = R1 * r_in;
      elseif frame_r_out == ResolveInFrameAB.frame_a then
         r_out = transpose({{cos(frame_a.phi), -sin(frame_a.phi),0}, {sin(frame_a.phi),cos(frame_a.phi),0},{0,0,1}}) * (R1 * r_in);
      elseif frame_r_out == ResolveInFrameAB.frame_b then
         r_out = transpose({{cos(frame_b.phi), -sin(frame_b.phi),0}, {sin(frame_b.phi),cos(frame_b.phi),0},{0,0,1}}) * (R1 * r_in);
      else
         r_out = transpose({{cos(frame_resolve.phi), -sin(frame_resolve.phi),0}, {sin(frame_resolve.phi),cos(frame_resolve.phi),0},{0,0,1}}) * (R1 * r_in);
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
