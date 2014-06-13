within PlanarMechanics.Interfaces;
partial model PartialTwoFlanges "Partial model with 2 flanges"

  Frame_a frame_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Frame_b frame_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  annotation (Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>This is a partial model with 2 planar flanges. it can be inherited to build up models with 2 planar flanges.</p>
</html>"));
end PartialTwoFlanges;
