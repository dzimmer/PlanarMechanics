within PlanarMechanics.Examples;
model CraneCrabMBS "A damped crane crab - fully 3-dimensional model"
  extends Modelica.Icons.Example;

  MB.Parts.Body body3D(r_CM=zeros(3), m=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-20})));
  MB.Parts.Body body1(
    m=1,
    r_CM=zeros(3),
    I_33=0.1)
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  MB.Parts.Body body2(
    m=0.5,
    r_CM=zeros(3),
    I_33=0.1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-80})));
  MB.Joints.Prismatic prismatic3D(
    s(fixed=true, start=-0.2),
    useAxisFlange=false,
    v(fixed=true, start=0.2),
    n={1,0,0},
    stateSelect=StateSelect.always)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,10})));
  MB.Joints.Prismatic prismatic(
    v(fixed=true),
    s(fixed=true, start=0),
    useAxisFlange=true,
    stateSelect=StateSelect.always)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  MB.Joints.Revolute revolute(w(fixed=true),
    n={0,0,1},
    stateSelect=StateSelect.always,
    phi(fixed=true, start=2.6179938779915))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-20})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=10)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  MB.Parts.FixedRotation fixedRotation3D(n={0,1,0}, angle=45) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,10})));
  MB.Parts.FixedTranslation fixedTranslation(r={0,-1,0}) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-50})));
  inner MB.World world(n={0,-1,0})
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
equation
  connect(fixedTranslation.frame_b, body2.frame_a) annotation (Line(
      points={{60,-60},{60,-70}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, body1.frame_a) annotation (Line(
      points={{60,-10},{60,10},{70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, fixedTranslation.frame_a) annotation (Line(
      points={{60,-30},{60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{40,10},{70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(body3D.frame_a, prismatic3D.frame_b) annotation (Line(
      points={{6.66134e-016,-10},{6.66134e-016,10},{-10,10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_a, world.frame_b) annotation (Line(
      points={{-70,10},{-80,10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedRotation3D.frame_b, prismatic3D.frame_a) annotation (Line(
      points={{-50,10},{-30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1D.flange_a, prismatic.support) annotation (Line(points={{20,40},{20,16},{26,16}},
                                    color={0,127,0}));
  connect(prismatic.axis, damper1D.flange_b) annotation (Line(points={{38,16},{40,16},{40,40}},         color={0,127,0}));
  connect(prismatic.frame_a, prismatic3D.frame_b) annotation (Line(
      points={{20,10},{-10,10}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=10),
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<h4>Comparison of planar and 3-dimensional model simulation</h4>
<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
<tr><td><b>TRANSLATION of</b>                              </td><td><b>CraneCrabTo3D</b></td><td><b>CraneCrabMBS</b> </td></tr>
<tr><td>The DAE has scalar unknowns                        </td><td> 4590               </td><td> 3264               </td></tr>
<tr><td>and scalar equations                               </td><td> 4590               </td><td> 3264               </td></tr>
<tr><td colspan=\"3\">Statistics                                                                                       </td></tr>
<tr><td></td><td colspan=\"2\">Original Model                                                                          </td></tr>
<tr><td>Number of components:                              </td><td> 201                </td><td> 151                </td></tr>
<tr><td>Variables:                                         </td><td> 2091               </td><td> 1521               </td></tr>
<tr><td>Constants:                                         </td><td> 1 (1 scalars)      </td><td> 3 (3 scalars)      </td></tr>
<tr><td>Parameters:                                        </td><td> 315 (419 scalars)  </td><td> 282 (459 scalars)  </td></tr>
<tr><td>Unknowns:                                          </td><td> 1775 (4590 scalars)</td><td> 1236 (3264 scalars)</td></tr>
<tr><td>Differentiated variables:                          </td><td> 29 scalars         </td><td> 36 scalars         </td></tr>
<tr><td>Equations:                                         </td><td> 1644               </td><td> 1148               </td></tr>
<tr><td>Nontrivial:                                        </td><td> 873                </td><td> 600                </td></tr>
<tr><td></td><td colspan=\"2\">Translated Model                                                                        </td></tr>
<tr><td>Constants:                                         </td><td> 2552 scalars       </td><td> 2240 scalars       </td></tr>
<tr><td>Free parameters:                                   </td><td> 77 scalars         </td><td> 91 scalars         </td></tr>
<tr><td>Parameter depending:                               </td><td> 706 scalars        </td><td> 372 scalars        </td></tr>
<tr><td>Continuous time states:                            </td><td> 6 scalars          </td><td> 6 scalars          </td></tr>
<tr><td>Time-varying variables:                            </td><td> 144 scalars        </td><td> 122 scalars        </td></tr>
<tr><td>Alias variables:                                   </td><td> 1531 scalars       </td><td> 901 scalars        </td></tr>
<tr><td>Number of mixed real/discrete systems of equations:</td><td> 0                  </td><td> 0                  </td></tr>
<tr><td>Sizes of linear systems of equations:              </td><td> {34, 3, 3}         </td><td> {4, 13}            </td></tr>
<tr><td>Sizes after manipulation of the linear systems:    </td><td> {5, 3, 3}          </td><td> {0, 2}             </td></tr>
<tr><td>Sizes of nonlinear systems of equations:           </td><td> { }                </td><td> { }                </td></tr>
<tr><td>Sizes after manipulation of the nonlinear systems: </td><td> { }                </td><td> { }                </td></tr>
<tr><td>Number of numerical Jacobians:                     </td><td> 0                  </td><td> 0                  </td></tr>
<tr><td>                                                   </td><td>                    </td><td>                    </td></tr>
<tr><td>Selected continuous time states                    </td><td>                    </td><td>                    </td></tr>
<tr><td>                                                   </td><td> prismatic.s        </td><td> prismatic.s        </td></tr>
<tr><td>                                                   </td><td> prismatic.v        </td><td> prismatic.v        </td></tr>
<tr><td>                                                   </td><td> prismatic3D.s      </td><td> prismatic3D.s      </td></tr>
<tr><td>                                                   </td><td> prismatic3D.v      </td><td> prismatic3D.v      </td></tr>
<tr><td>                                                   </td><td> revolute.phi       </td><td> revolute.phi       </td></tr>
<tr><td>                                                   </td><td> revolute.w         </td><td> revolute.w         </td></tr>
<tr><td colspan=\"3\"><b>SIMULATION</b>                                                          </td></tr>
<tr><td>CPU-time for integration      :</td><td>0.03 seconds       </td><td>0.012 seconds      </td></tr>
<tr><td>CPU-time for one GRID interval:</td><td>0.06 milli-seconds </td><td>0.024 milli-seconds</td></tr>
<tr><td>Number of result points       :</td><td>502                </td><td>502                </td></tr>
<tr><td>Number of GRID   points       :</td><td>501                </td><td>501                </td></tr>
<tr><td>Number of (successful) steps  :</td><td>957                </td><td>701                </td></tr>
<tr><td>Number of F-evaluations       :</td><td>2437               </td><td>1497               </td></tr>
<tr><td>Number of Jacobian-evaluations:</td><td>84                 </td><td>16                 </td></tr>
<tr><td>Number of (model) time events :</td><td>0                  </td><td>0                  </td></tr>
<tr><td>Number of (U) time events     :</td><td>0                  </td><td>0                  </td></tr>
<tr><td>Number of state    events     :</td><td>0                  </td><td>0                  </td></tr>
<tr><td>Number of step     events     :</td><td>0                  </td><td>0                  </td></tr>
<tr><td>Minimum integration stepsize  :</td><td>2.28e-007          </td><td>2.28e-007          </td></tr>
<tr><td>Maximum integration stepsize  :</td><td>0.0258             </td><td>0.0242             </td></tr>
<tr><td>Maximum integration order     :</td><td>5                  </td><td>5                  </td></tr>
</table>
</html></html>"));
end CraneCrabMBS;
