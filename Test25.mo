model Test25
  BusController.Device device1(T = 5e-6, cache = {6, 6, 11, 12, 13, 14, 15, 16, 0, 0}, enableReceiveFilter = true, nodeId = 16) annotation(
    Placement(transformation(origin = {-178, 0}, extent = {{-20, -20}, {20, 20}})));
  BusController.Device device2(T = 5e-6, cache = {8, 6, 21, 22, 23, 24, 25, 26, 0, 0}, enableReceiveFilter = true, nodeId = 32) annotation(
    Placement(transformation(origin = {142, 0}, extent = {{20, -20}, {-20, 20}})));
  BusController.Device device3(T = 260e-6, cache = {2, 6, 31, 32, 33, 34, 35, 36, 0, 0}, enableReceiveFilter = true, nodeId = 48) annotation(
    Placement(transformation(origin = {-114, -42}, extent = {{-20, -20}, {20, 20}})));
  BusController.Device device4(T = 260e-6, cache = {4, 6, 41, 42, 43, 44, 45, 46, 0, 0}, enableReceiveFilter = true, nodeId = 64) annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-20, -20}, {20, 20}})));
Modelica.Electrical.Analog.Basic.Resistor terminator(R = 100) annotation(
    Placement(transformation(origin = {-147, 0}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor terminator1(R = 100) annotation(
    Placement(transformation(origin = {112, 1}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
  BusController.CANTwistedPair twistedPair(length = 10) annotation(
    Placement(transformation(origin = {-109.333, -0.307692}, extent = {{-18.6667, -12.9231}, {18.6667, 12.9231}})));
  BusController.CANTwistedPair twistedPair1(length = 10) annotation(
    Placement(transformation(origin = {67.667, 0.6923}, extent = {{-18.6667, -12.9231}, {18.6667, 12.9231}})));
  BusController.CANTwistedPair twistedPair11(length = 10) annotation(
    Placement(transformation(origin = {-17.333, -0.3077}, extent = {{-18.6667, -12.9231}, {18.6667, 12.9231}})));
  equation
  connect(terminator.n, device1.pin_can_L) annotation(
    Line(points = {{-147, -8}, {-158, -8}}, color = {0, 0, 255}));
  connect(terminator.p, device1.pin_can_H) annotation(
    Line(points = {{-147, 8}, {-158, 8}}, color = {0, 0, 255}));
  connect(terminator1.p, device2.pin_can_H) annotation(
    Line(points = {{112, 9}, {112, 8.5}, {122, 8.5}, {122, 8}}, color = {0, 0, 255}));
  connect(terminator1.n, device2.pin_can_L) annotation(
    Line(points = {{112, -7}, {112, -7.5}, {122, -7.5}, {122, -8}}, color = {0, 0, 255}));
  connect(device1.pin_can_H, twistedPair.H_a) annotation(
    Line(points = {{-158, 8}, {-128, 8}, {-128, 7}}, color = {0, 0, 255}));
  connect(device1.pin_can_L, twistedPair.L_a) annotation(
    Line(points = {{-158, -8}, {-128, -8}}, color = {0, 0, 255}));
  connect(twistedPair1.H_b, device2.pin_can_H) annotation(
    Line(points = {{86, 8}, {122, 8}}, color = {0, 0, 255}));
  connect(twistedPair1.L_b, device2.pin_can_L) annotation(
    Line(points = {{86, -7}, {122, -7}, {122, -8}}, color = {0, 0, 255}));
  connect(device3.pin_can_H, twistedPair.H_b) annotation(
    Line(points = {{-94, -34}, {-74, -34}, {-74, 8}, {-90, 8}}, color = {0, 0, 255}));
  connect(device3.pin_can_L, twistedPair.L_b) annotation(
    Line(points = {{-94, -50}, {-60, -50}, {-60, -8}, {-90, -8}}, color = {0, 0, 255}));
  connect(twistedPair.H_b, twistedPair11.H_a) annotation(
    Line(points = {{-90, 8}, {-36, 8}}, color = {0, 0, 255}));
  connect(twistedPair.L_b, twistedPair11.L_a) annotation(
    Line(points = {{-90, -8}, {-36, -8}}, color = {0, 0, 255}));
  connect(twistedPair11.H_b, twistedPair1.H_a) annotation(
    Line(points = {{2, 8}, {50, 8}}, color = {0, 0, 255}));
  connect(twistedPair11.L_b, twistedPair1.L_a) annotation(
    Line(points = {{2, -8}, {50, -8}}, color = {0, 0, 255}));
  connect(device4.pin_can_H, twistedPair1.H_a) annotation(
    Line(points = {{20, -32}, {28, -32}, {28, 8}, {50, 8}}, color = {0, 0, 255}));
  connect(device4.pin_can_L, twistedPair1.L_a) annotation(
    Line(points = {{20, -48}, {38, -48}, {38, -8}, {50, -8}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
  Diagram(coordinateSystem(extent = {{-200, 20}, {160, -60}})),
  version = "");
end Test25;
