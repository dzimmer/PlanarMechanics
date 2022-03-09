within PlanarMechanics.VehicleComponents.Wheels.BaseClasses;
partial model WheelInterfaces "Partial base class containing common wheel interfaces"
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-54,-16},
            {-22,16}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(
          extent={{90,-10},{110,10}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This partial class contains common connectors needed for wheel models.
In particular, <code>frame_a</code> is intended to connected a&nbsp;wheel
carrier (also called upright) and <code>flange_a</code> to connect
a&nbsp;driveline.
This class should be extended to create
a&nbsp;proper model, see e.g.
<a href=\"modelica://PlanarMechanics.VehicleComponents.Wheels.IdealWheelJoint\">IdealWheelJoint</a> model.
</p>
<p>
Note: If this model is used, the loss power has to be provided by an equation
in the model which inherits from the
</p>
<blockquote><pre>
WheelInterfaces model(<strong>lossPower = ...</strong>).
</pre></blockquote>
</html>"));
end WheelInterfaces;
