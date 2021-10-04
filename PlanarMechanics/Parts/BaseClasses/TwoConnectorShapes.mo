within PlanarMechanics.Parts.BaseClasses;
partial model TwoConnectorShapes
  "Partial base class containing two frames and cylinder shapes at these frames"
  extends PlanarMechanics.Interfaces.PartialTwoFrames;

  parameter Boolean animate = true "Enable animation"
    annotation(Dialog(group="Animation"));

  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  input Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (HideResult=true, Dialog(tab="Animation", group="if animation = true", enable=animate));

  parameter Boolean animateConnectors = true
    "=true, if connectors a and b should be animated as cylinders"
    annotation (Dialog(tab="Animation", group="Connectors (if animation = true)", enable=animate));
  parameter SI.Diameter diameterConnector_a=planarWorld.defaultJointWidth
    "Diameter of connector at frame_a"
    annotation (Dialog(tab="Animation", group="Connectors (if animation = true)", enable=animate and animateConnectors));
  parameter SI.Diameter diameterConnector_b=planarWorld.defaultJointWidth
    "Diameter of connector at frame_b"
    annotation (Dialog(tab="Animation", group="Connectors (if animation = true)", enable=animate and animateConnectors));
  input Types.Color colorConnector_a = Types.Defaults.RodColor
    "Color of connector at frame_a"
    annotation (HideResult=true, Dialog(colorSelector=true, tab="Animation", group="Connectors (if animation = true)", enable=animate and animateConnectors));
  input Types.Color colorConnector_b = Types.Defaults.RodColor
    "Color of connector at frame_a"
    annotation (HideResult=true, Dialog(colorSelector=true, tab="Animation", group="Connectors (if animation = true)", enable=animate and animateConnectors));

protected
  MB.Visualizers.Advanced.Shape contactA(
    shapeType="cylinder",
    color=colorConnector_a,
    specularCoefficient=specularCoefficient,
    length=planarWorld.defaultJointLength,
    width=diameterConnector_a,
    height=diameterConnector_a,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={frame_a.x,frame_a.y,zPosition}+{0,0,-planarWorld.defaultJointLength/2},
    r=planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate and animateConnectors;
  MB.Visualizers.Advanced.Shape contactB(
    shapeType="cylinder",
    color=colorConnector_b,
    specularCoefficient=specularCoefficient,
    length=planarWorld.defaultJointLength,
    width=diameterConnector_b,
    height=diameterConnector_b,
    lengthDirection={0,0,1},
    widthDirection={1,0,0},
    r_shape={frame_b.x,frame_b.y,zPosition}+{0,0,-planarWorld.defaultJointLength/2},
    r=planarWorld.r_0,
    R=planarWorld.R) if planarWorld.enableAnimation and animate and animateConnectors;

  annotation (
    Icon(graphics={
        Text(
          extent={{-108,-24},{-72,-49}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,-24},{108,-49}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010-2020 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>",  info="<html>
<p>
This partial base class contains two frames and optionally enables to visualize
a&nbsp;cylinder at place of each of these frames. This class should be extended
to create a&nbsp;proper model, see e.g.
<a href=\"modelica://PlanarMechanics.Parts.Spring\">Spring</a> model.
</p>
</html>"));
end TwoConnectorShapes;
