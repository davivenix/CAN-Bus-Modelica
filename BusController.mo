package BusController
  model CANController
    parameter Real T_Q = 1;
    parameter Integer N_tq = 16;
    parameter Integer PROP_SEG_TQ = 7;
    parameter Boolean forceAckErrorOnce = false;
    parameter Integer nodeId(min = 0, max = 2047) = 0;
    parameter Boolean enableReceiveFilter = false;
    Buffer TransmitBuffer(N = 10)  annotation(
      Placement(transformation(origin = {-60, -30}, extent = {{-30, -30}, {30, 30}})));
    Buffer ReceiveBuffer(N = 10)  annotation(
      Placement(transformation(origin = {-60, 30}, extent = {{30, -30}, {-30, 30}})));
  CANCore5 cANCore5(T_Q = T_Q, N_tq = N_tq, PROP_SEG_TQ = PROP_SEG_TQ, forceAckErrorOnce = forceAckErrorOnce, nodeId = nodeId, enableReceiveFilter = enableReceiveFilter) annotation(
      Placement(transformation(origin = {43.25, 2}, extent = {{-47.25, -54}, {47.25, 54}})));
  Modelica.Blocks.Interfaces.BooleanInput StartSend annotation(
      Placement(transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput RBS annotation(
      Placement(transformation(origin = {-110, -80}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, -80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Interfaces.BooleanInput WriteTrig annotation(
      Placement(transformation(origin = {-120, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput ReadTrig annotation(
      Placement(transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput WriteData annotation(
      Placement(transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerOutput ReadData annotation(
      Placement(transformation(origin = {-110, 20}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, 20}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Interfaces.BooleanInput Rx annotation(
      Placement(transformation(origin = {110, -62}, extent = {{20, -20}, {-20, 20}}, rotation = -0), iconTransformation(origin = {110, -70}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Interfaces.BooleanOutput Tx annotation(
      Placement(transformation(origin = {112, 56}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
      Placement(transformation(origin = {-120, 2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, -20}, extent = {{-10, -10}, {10, 10}})));
  equation
  connect(TransmitBuffer.readData, cANCore5.DataFromBuffer) annotation(
      Line(points = {{-32, -30}, {-18, -30}, {-18, -4}, {2, -4}}, color = {255, 127, 0}));
  connect(cANCore5.DataToBuffer, ReceiveBuffer.writeData) annotation(
      Line(points = {{6, -22}, {-12, -22}, {-12, 30}, {-32, 30}}, color = {255, 127, 0}));
  connect(cANCore5.Tx, Tx) annotation(
      Line(points = {{80, 50}, {90, 50}, {90, 56}, {112, 56}}, color = {255, 0, 255}));
  connect(Rx, cANCore5.Rx) annotation(
      Line(points = {{110, -62}, {96, -62}, {96, 8}, {84, 8}}, color = {255, 0, 255}));
  connect(StartSend, cANCore5.SendFrameSignal) annotation(
      Line(points = {{-120, 80}, {-10, 80}, {-10, 48}, {2, 48}}, color = {255, 0, 255}));
  connect(ReceiveBuffer.readData, ReadData) annotation(
      Line(points = {{-86, 30}, {-96, 30}, {-96, 20}, {-110, 20}}, color = {255, 127, 0}));
  connect(cANCore5.readingControlSignal, TransmitBuffer.readTrig) annotation(
      Line(points = {{6, 34}, {-8, 34}, {-8, -62}, {-94, -62}, {-94, -50}, {-86, -50}}, color = {255, 0, 255}));
  connect(cANCore5.writingControlSignal, ReceiveBuffer.writeTrig) annotation(
      Line(points = {{6, -36}, {-22, -36}, {-22, 18}, {-32, 18}}, color = {255, 0, 255}));
  connect(ReadTrig, ReceiveBuffer.readTrig) annotation(
      Line(points = {{-120, 40}, {-90, 40}, {-90, 66}, {-26, 66}, {-26, 10}, {-32, 10}}, color = {255, 0, 255}));
  connect(WriteTrig, TransmitBuffer.writeTrig) annotation(
      Line(points = {{-120, -50}, {-96, -50}, {-96, -42}, {-86, -42}}, color = {255, 0, 255}));
  connect(WriteData, TransmitBuffer.writeData) annotation(
      Line(points = {{-120, -20}, {-94, -20}, {-94, -30}, {-86, -30}}, color = {255, 127, 0}));
  connect(TxFrameInfo, cANCore5.TxFrameInfo) annotation(
      Line(points = {{-120, 2}, {-16, 2}, {-16, 16}, {2, 16}}, color = {255, 127, 0}));
  RBS = not ReceiveBuffer.empty;
  annotation(
      Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 110}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-70, 80}, extent = {{-30, 10}, {30, -10}}, textString = "StartSend"), Text(origin = {-70, -60}, extent = {{-30, 10}, {30, -10}}, textString = "WriteTrig"), Text(origin = {-70, 20}, extent = {{-30, 10}, {30, -10}}, textString = "ReadData"), Text(origin = {-70, -20}, extent = {{-30, 10}, {30, -10}}, textString = "TxFrameInfo"), Text(origin = {-70, -40}, extent = {{-30, 10}, {30, -10}}, textString = "WriteData"), Text(origin = {-70, 40}, extent = {{-30, 10}, {30, -10}}, textString = "ReadTrig"), Text(origin = {-70, -80}, extent = {{-30, 10}, {30, -10}}, textString = "RBS"), Text(origin = {70, 70}, extent = {{-30, 10}, {30, -10}}, textString = "Tx"), Text(origin = {70, -70}, extent = {{-30, 10}, {30, -10}}, textString = "Rx")}, coordinateSystem(extent = {{-120, 120}, {120, -100}})),
  Diagram(graphics));
end CANController;

  model CANBusLogic
    parameter Integer N = 2 "Number of connected CAN controllers";
    parameter Modelica.Units.SI.Time propagationDelay = 1e-9;
    Modelica.Blocks.Interfaces.BooleanInput Tx[N] annotation(
      Placement(transformation(origin = {-110, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 0}, extent = {{-10, -40}, {10, 40}})));
    Modelica.Blocks.Interfaces.BooleanOutput Rx[N] annotation(
      Placement(transformation(origin = {110, 0}, extent = {{-10, -20}, {10, 20}}), iconTransformation(origin = {110, 0}, extent = {{-10, -40}, {10, 40}})));
    discrete Boolean busLevel(start = true);
  algorithm
    when {initial(), sample(0, propagationDelay)} then
      busLevel := sum({utils.boolToInt(pre(Tx[i])) for i in 1:N}) == N;
    end when;
  equation
    Rx = fill(busLevel, N);
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}), Text(origin = {0, 70}, extent = {{-70, 10}, {70, -10}}, textString = "%name"), Text(origin = {-70, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Tx"), Text(origin = {70, 0}, extent = {{-30, 10}, {30, -10}}, textString = "Rx")}));
  end CANBusLogic;

  model Buffer
    parameter Integer N = 10 "Buffer capacity";
    // 闃熷垪鏁扮粍
    //parameter Integer init_buffer[N] = {0,0,0,0,0,0,0,0,0,0};
    Integer buffer[N];
    // 澶栭儴鎺ュ彛
    Modelica.Blocks.Interfaces.IntegerInput writeData annotation(
      Placement(transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
    discrete Modelica.Blocks.Interfaces.IntegerOutput readData annotation(
      Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput writeTrig annotation(
      Placement(transformation(origin = {-100, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput readTrig annotation(
      Placement(transformation(origin = {-100, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
    discrete Modelica.Blocks.Interfaces.BooleanOutput full annotation(
      Placement(transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -40}, extent = {{-10, -10}, {10, 10}})));
    discrete Modelica.Blocks.Interfaces.BooleanOutput empty annotation(
      Placement(transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}})));
  protected
    discrete Integer head(start = 1), tail(start = 1), count(start = 0);
  initial algorithm
    readData := 0;
//buffer := init_buffer;
  algorithm
    full := count >= N;
    empty := count <= 0;
//readData := buffer[tail];
// 鍐欏叆閫昏緫
    when writeTrig and not full then
      buffer[head] := writeData;
      head := if head == N then 1 else head + 1;
      count := count + 1;
    end when;
// 璇诲彇閫昏緫
    when readTrig and not empty then
      readData := buffer[tail];
      tail := if tail == N then 1 else tail + 1;
      count := count - 1;
    end when;
    annotation(
      Icon(graphics = {Rectangle(fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Bitmap(origin = {-8, 67}, extent = {{0, -13}, {0, 13}}), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-51, 3}, extent = {{-29, 9}, {29, -9}}, textString = "writeData"), Text(origin = {-51, -39}, extent = {{-29, 9}, {29, -9}}, textString = "writeTrig"), Text(origin = {-51, -69}, extent = {{-29, 9}, {29, -9}}, textString = "readTrig"), Text(origin = {51, 3}, extent = {{-29, 9}, {29, -9}}, textString = "readData"), Text(origin = {51, -37}, extent = {{-29, 9}, {29, -9}}, textString = "full"), Text(origin = {51, -69}, extent = {{-29, 9}, {29, -9}}, textString = "empty")}),
      Diagram(graphics));
  end Buffer;

  model MCU
    parameter Real T = 5e-6;
    parameter Integer cache[10] = fill(1, 10);
    parameter Real clk_period = 1;
    Integer memory[10](start = fill(0, 10));
    Modelica.Blocks.Interfaces.IntegerOutput writeData(start = 1) annotation(
      Placement(transformation(origin = {90, -30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput writeDataSignal(start = false) annotation(
      Placement(transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput sendData(start = false) annotation(
      Placement(transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput RBS annotation(
      Placement(transformation(origin = {90, 52}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {90, 50}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput readData annotation(
      Placement(transformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {90, 30}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput readDataSignal(start = false) annotation(
      Placement(transformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.IntegerOutput TxFrameInfo(start = 0) annotation(
      Placement(transformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}})));
    Integer count(start = 0);
    Integer cache_pin(start = 1);
    Integer mem_pin(start = 1);
    Boolean sendOneFrame(start = false);
    Integer sendFrameLength(start = 0);
    Boolean receiveOneFrame(start = false);
    Integer a(start = 0);
    Integer b(start = 0);
    Integer readLength(start = 0);
  Modelica.Blocks.Sources.BooleanPulse clk(period = clk_period)  annotation(
      Placement(transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}})));
  algorithm
//鍦ㄧT绉掑皢鍐呭瓨涓暟鎹彂閫佺粰缂撳啿鍣?
    when time >= T then
      sendOneFrame := true;
      sendFrameLength := 10;
//TxFrameInfo := 8;
      b := 8;
      Modelica.Utilities.Streams.print("TxFrameInfo = " + String(TxFrameInfo));
    end when;
    when RBS then
      if not receiveOneFrame then
        receiveOneFrame := true;
        readLength := 10;
      end if;
    end when;
  
    when clk.y then
      if sendOneFrame then
//杩涘叆鍙戦€侀€昏緫
        b := 8;
        Modelica.Utilities.Streams.print("TxFrameInfo = " + String(TxFrameInfo));
        if sendFrameLength > count then
          if not writeDataSignal then
            a := cache[cache_pin];
//writeData := a;
            Modelica.Utilities.Streams.print("cache[cache_pin] = " + String(cache[cache_pin]));
            Modelica.Utilities.Streams.print("writeData = " + String(writeData));
            writeDataSignal := true;
          else
            writeDataSignal := false;
            cache_pin := cache_pin + 1;
            count := count + 1;
          end if;
        else
//sendData := true;
          sendOneFrame := false;
          count := 0;
          cache_pin := 1;
//writeData := 0;
        end if;
      //if sendData then
//  sendData := false;
//end if;
elseif receiveOneFrame then
//杩涘叆鎺ユ敹閫昏緫
        if readLength > 0 then
          if not readDataSignal then
            readDataSignal := true;
          else
            memory[mem_pin] := readData;
            mem_pin := mem_pin + 1;
            readLength := readLength - 1;
            readDataSignal := false;
          end if;
        else
          receiveOneFrame := false;
          mem_pin := 1;
          
        end if;
      end if;
    end when;
  equation
    writeData = a;
    sendData = time>=(T+clk_period*21);
    TxFrameInfo = 6;
    annotation(
      Diagram(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Rectangle(extent = {{-60, 60}, {60, -60}})}),
      Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-50, -70}, extent = {{-30, 10}, {30, -10}}, textString = "ClockIn"), Text(origin = {40, 70}, extent = {{-40, 10}, {40, -10}}, textString = "readDataSignal"), Text(origin = {40, 52}, extent = {{-40, 10}, {40, -10}}, textString = "RBS"), Text(origin = {40, 30}, extent = {{-40, 10}, {40, -10}}, textString = "readData"), Text(origin = {40, -30}, extent = {{-40, 10}, {40, -10}}, textString = "writeData"), Text(origin = {40, -50}, extent = {{-40, 10}, {40, -10}}, textString = "writeDataSignal"), Text(origin = {40, -70}, extent = {{-40, 10}, {40, -10}}, textString = "sendData"), Text(origin = {40, 10}, extent = {{-40, 10}, {40, -10}}, textString = "RxFrameInfo"), Text(origin = {40, -10}, extent = {{-40, 10}, {40, -10}}, textString = "TxFrameInfo")}),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian");
  end MCU;

  model CANCore
    
    parameter Real F = 1e6 "Baud rate";
    parameter Real F_osc = 16e6 "Oscillator frequency";
    parameter Integer PROP_SEG_TQ = 7 "Propagation segment time quanta";
    parameter Integer PHASE_SEG2_TQ = 8 "Phase segment 2 time quanta";
    Real z(start = 0);
    Boolean Record[200](start = fill(false, 200));
    Boolean ID[11](start = fill(false, 11));
    Boolean RTR(start = false);
    Boolean ArbData[12](start = fill(false, 12));
    Boolean IDE(start = false);
    Boolean r0 = false;
    Boolean DLC[4](start = fill(false, 4));
    Integer dataLength(start = 0);
    Boolean noData(start = true);
    Boolean Data[64](start = fill(false, 64));
    Boolean CRC[15](start = fill(false, 15));
    Boolean CRCE(start = true);
    Boolean ACK(start = true);
    Boolean ACKE(start = true);
    Boolean EOF[7](start = fill(false, 7));
    Modelica.Blocks.Interfaces.BooleanOutput Tx annotation(
      Placement(transformation(origin = {330, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput Rx annotation(
      Placement(transformation(origin = {330, -116}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {90, -30}, extent = {{10, -10}, {-10, 10}})));
    Modelica.StateGraph.InitialStep Idle(nOut = 1, nIn = 2) annotation(
      Placement(transformation(origin = {-254, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal whenRxLow annotation(
      Placement(transformation(origin = {-228, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression whenRxFalse(y = not Rx or sending) annotation(
      Placement(transformation(origin = {-252, 44}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal Sync(nIn = 3, nOut = 2) annotation(
      Placement(transformation(origin = {-208, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.InitialStep SYNC_SEG(nOut = 1, nIn = 1) annotation(
      Placement(transformation(origin = {148, -144}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal TQ1 annotation(
      Placement(transformation(origin = {172, -144}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.Step PROP_SEG(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {192, -144}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal TQ2 annotation(
      Placement(transformation(origin = {214, -144}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal TQ3 annotation(
      Placement(transformation(origin = {254, -144}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = tQCounter.y >= 1) annotation(
      Placement(transformation(origin = {152, -176}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = tQCounter.y >= PROP_SEG_TQ + 1) annotation(
      Placement(transformation(origin = {192, -176}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = tQCounter.y == 0) annotation(
      Placement(transformation(origin = {234, -176}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal PHASE_SEG2(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {234, -144}, extent = {{-10, -10}, {10, 10}})));
    BitCounter bitCounter annotation(
      Placement(transformation(origin = {-214, 14}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal bit1 annotation(
      Placement(transformation(origin = {-180, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression whenbit1(y = (tQCounter.y >= N_tq - 1) and sending) annotation(
      Placement(transformation(origin = {-194, 44}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal Arb(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {-158, 70}, extent = {{-10, -10}, {10, 10}})));
    TQCounter tQCounter(N_tq = N_tq) annotation(
      Placement(transformation(origin = {-232, 14}, extent = {{-10, -10}, {10, 10}})));
    TQTimer tQTimer(TQ = T_Q) annotation(
      Placement(transformation(origin = {-252, 14}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal Receive(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {-114, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal toReveive annotation(
      Placement(transformation(origin = {-134, -10}, extent = {{-10, -10}, {10, 10}})));
    Boolean changeToReceive(start = false);
    Boolean sending(start = false);
    Boolean sendWaiting(start = false);
    Boolean receiving(start = false);
    Integer dlc_received(start = 0);
    Integer frameLength(start = 44);
    Integer readDataLength(start = 0);
    Boolean crc_received[15](start = fill(false, 15));
    model RxSampler
      extends Modelica.Blocks.Icons.DiscreteBlock;
      parameter Boolean y_start = true "Initial value of output signal";
      Modelica.Blocks.Interfaces.BooleanInput u "Connector with a Boolean input signal" annotation(
        Placement(transformation(origin = {0, 60}, extent = {{-140, -20}, {-100, 20}}), iconTransformation(origin = {0, 64}, extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y "Connector with a Boolean output signal" annotation(
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger input" annotation(
        Placement(transformation(origin = {0, -118}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanInput v annotation(
        Placement(transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}})));
    equation
      when trigger then
        y = (u and not v) or (v and not u);
      end when;
    initial equation
      y = y_start;
    end RxSampler;

    model TQCounter
      parameter Integer N_tq = 16;
      Modelica.Blocks.Interfaces.BooleanInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      when y >= N_tq then
        y := 0;
      end when;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%N_tq")}));
    end TQCounter;

    model TQTimer
      parameter Real TQ = 1;
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Real x(start = 0);
    equation
      der(x) = 1;
      when reset then
        reinit(x, 0);
      end when;
      when x >= TQ then
        reinit(x, 0);
      end when;
      y = x < TQ/2;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%TQ")}));
    end TQTimer;

    model BitCounter
      Modelica.Blocks.Interfaces.IntegerInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count == 0 then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})),
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name")}));
    end BitCounter;

    Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
      Placement(transformation(origin = {-300, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal startReceiving annotation(
      Placement(transformation(origin = {-180, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression whenBit1AndNotSending(y = (tQCounter.y >= N_tq - 1) and not sending) annotation(
      Placement(transformation(origin = {-194, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal arbSuccess annotation(
      Placement(transformation(origin = {-134, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression bitCount13(y = (bitCounter.y >= 13) and sending) annotation(
      Placement(transformation(origin = {-158, 44}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal SendIDE(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-114, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal ideSend annotation(
      Placement(transformation(origin = {-94, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression bitCount14(y = bitCounter.y >= 14) annotation(
      Placement(transformation(origin = {-114, 44}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal Sendr0(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression bitCount15(y = bitCounter.y >= 15) annotation(
      Placement(transformation(origin = {-74, 44}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal r0Send annotation(
      Placement(transformation(origin = {-54, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal SendDLC(nOut = 2, nIn = 1) annotation(
      Placement(transformation(origin = {-34, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal dlcSend annotation(
      Placement(transformation(origin = {-14, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression bitCount19(y = (bitCounter.y >= 19) and not noData) annotation(
      Placement(transformation(origin = {-34, 44}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal ReceiveDLC(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {-34, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal ider0Received annotation(
      Placement(transformation(origin = {-54, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal dlcReceived annotation(
      Placement(transformation(origin = {-14, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal SendData(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {6, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal ReceiveData(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {6, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal dataSend annotation(
      Placement(transformation(origin = {26, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal dataReceived annotation(
      Placement(transformation(origin = {26, -10}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal SendCRC(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {46, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal ReceiveCRC(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {46, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataSend annotation(
      Placement(transformation(origin = {26, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndnoData(y = (bitCounter.y >= 19) and noData)  annotation(
      Placement(transformation(origin = {-34, 14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataReveive annotation(
      Placement(transformation(origin = {26, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcSend annotation(
      Placement(transformation(origin = {66, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRCE(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {86, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceSend annotation(
      Placement(transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACK(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {126, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackSend annotation(
      Placement(transformation(origin = {146, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACKE(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {166, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeSend annotation(
      Placement(transformation(origin = {186, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendEOF(nIn = 1, nOut = 2)  annotation(
      Placement(transformation(origin = {206, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofSend annotation(
      Placement(transformation(origin = {226, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength(y = bitCounter.y >= (19 + dataLength))  annotation(
      Placement(transformation(origin = {6, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength(y = bitCounter.y >= (34 + dataLength))  annotation(
      Placement(transformation(origin = {46, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength(y = bitCounter.y >= (35 + dataLength))  annotation(
      Placement(transformation(origin = {86, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength(y = bitCounter.y >= (36 + dataLength))  annotation(
      Placement(transformation(origin = {126, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength(y = bitCounter.y >= (37 + dataLength))  annotation(
      Placement(transformation(origin = {166, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength(y =  (bitCounter.y >= (44 + dataLength))and not sendWaiting)  annotation(
      Placement(transformation(origin = {206, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcReceived annotation(
      Placement(transformation(origin = {66, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step ReceiveCRCE(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {86, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceReveived annotation(
      Placement(transformation(origin = {106, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACK(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {126, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackReceived annotation(
      Placement(transformation(origin = {146, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACKE(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {166, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeReceived annotation(
      Placement(transformation(origin = {186, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveEOF(nIn = 1, nOut = 2)  annotation(
      Placement(transformation(origin = {206, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofReceived annotation(
      Placement(transformation(origin = {226, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = (bitCounter.y >= (44 + dataLength)) and sendWaiting)  annotation(
      Placement(transformation(origin = {206, 16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending annotation(
      Placement(transformation(origin = {226, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending1 annotation(
      Placement(transformation(origin = {226, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
      Placement(transformation(origin = {-300, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep Wait(nOut = 1, nIn = 1)  annotation(
      Placement(transformation(origin = {-230, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startSendSignal annotation(
      Placement(transformation(origin = {-210, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReadFromBuffer(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {-190, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finishReading annotation(
      Placement(transformation(origin = {-170, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal sendingFrame(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {-150, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finishSendingFrame annotation(
      Placement(transformation(origin = {-130, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression startToSend(y = startSend)  annotation(
      Placement(transformation(origin = {-230, -124}, extent = {{-10, -10}, {10, 10}})));
  Integer i(start = 0);
  Integer readData[10](start = fill(0, 10));
  Integer frameInfo(start = 0);
  Boolean finishReadingFromBuffer(start = false);
  Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
      Placement(transformation(origin = {-290, -120}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
      Placement(transformation(origin = {-300, -140}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression finishReadingFromBuffer1(y = finishReadingFromBuffer)  annotation(
      Placement(transformation(origin = {-190, -124}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression finishSending(y = finishSendingToCAN)  annotation(
      Placement(transformation(origin = {-150, -124}, extent = {{-10, -10}, {10, 10}})));
  Boolean finishSendingToCAN(start = false);
  Boolean finishreceivingFromCAN(start = false);
  Modelica.Blocks.Sources.BooleanExpression toReceive1(y = changeToReceive)  annotation(
      Placement(transformation(origin = {-158, -32}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength1(y = bitCounter.y >= (19 + readDataLength)) annotation(
      Placement(transformation(origin = {5, -37}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength1(y = bitCounter.y >= (34 + readDataLength)) annotation(
      Placement(transformation(origin = {45, -37}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength1(y = bitCounter.y >= (35 + readDataLength)) annotation(
      Placement(transformation(origin = {85, -37}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength1(y = bitCounter.y >= (36 + readDataLength)) annotation(
      Placement(transformation(origin = {125, -37}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength1(y = bitCounter.y >= (37 + readDataLength)) annotation(
      Placement(transformation(origin = {165, -37}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength1(y = (bitCounter.y >= (44 + readDataLength)) and not sendWaiting) annotation(
      Placement(transformation(origin = {205, -37}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = (bitCounter.y >= (44 + readDataLength)) and sendWaiting) annotation(
      Placement(transformation(origin = {205, -65}, extent = {{-10, -10}, {10, 10}})));  
  
  
    parameter Real T_bit = 1/F;
    parameter Integer N_tq = 1 + PROP_SEG_TQ + PHASE_SEG2_TQ;
    parameter Real T_Q = T_bit/N_tq;
    Modelica.Blocks.Sources.BooleanPulse clk(period = 1/F_osc) annotation(
      Placement(transformation(origin = {-262, -202}, extent = {{-10, -10}, {10, 10}})));
    parameter Integer BRP = 1;
  //=================================================

    model CANCoreStateMech
    //========================================================================
    parameter Real T_Q = 1;
    parameter Integer N_tq = 16;
    parameter Integer PROP_SEG_TQ = 7;
    //========================================================================
  Modelica.StateGraph.InitialStep Idle(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-213, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal whenRxLow annotation(
        Placement(transformation(origin = {-187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenRxFalse(y =  sending) annotation(
        Placement(transformation(origin = {-211, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sync(nIn = 3, nOut = 2) annotation(
        Placement(transformation(origin = {-167, 67}, extent = {{-10, -10}, {10, 10}})));
  BusController.CANCore.BitCounter bitCounter annotation(
        Placement(transformation(origin = {-173, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal bit1 annotation(
        Placement(transformation(origin = {-139, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenbit1(y = (tQCounter.y >= N_tq - 1) and sending) annotation(
        Placement(transformation(origin = {-153, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Arb(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {-117, 67}, extent = {{-10, -10}, {10, 10}})));
  BusController.CANCore.TQCounter tQCounter(N_tq = N_tq) annotation(
        Placement(transformation(origin = {-191, 11}, extent = {{-10, -10}, {10, 10}})));
  BusController.CANCore.TQTimer tQTimer(TQ = T_Q) annotation(
        Placement(transformation(origin = {-211, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Receive(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-73, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal toReveive annotation(
        Placement(transformation(origin = {-93, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startReceiving annotation(
        Placement(transformation(origin = {-139, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenBit1AndNotSending(y = (tQCounter.y >= N_tq - 1) and not sending) annotation(
        Placement(transformation(origin = {-153, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal arbSuccess annotation(
        Placement(transformation(origin = {-93, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount13(y = (bitCounter.y >= 13) and sending) annotation(
        Placement(transformation(origin = {-117, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendIDE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-73, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ideSend annotation(
        Placement(transformation(origin = {-53, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount14(y = bitCounter.y >= 14) annotation(
        Placement(transformation(origin = {-73, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sendr0(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-33, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount15(y = bitCounter.y >= 15) annotation(
        Placement(transformation(origin = {-33, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal r0Send annotation(
        Placement(transformation(origin = {-13, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcSend annotation(
        Placement(transformation(origin = {27, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19(y = (bitCounter.y >= 19) and not noData) annotation(
        Placement(transformation(origin = {7, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ider0Received annotation(
        Placement(transformation(origin = {-13, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcReceived annotation(
        Placement(transformation(origin = {27, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataSend annotation(
        Placement(transformation(origin = {67, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataReceived annotation(
        Placement(transformation(origin = {67, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataSend annotation(
        Placement(transformation(origin = {67, 25}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndnoData(y = (bitCounter.y >= 19) and noData) annotation(
        Placement(transformation(origin = {7, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataReveive annotation(
        Placement(transformation(origin = {67, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcSend annotation(
        Placement(transformation(origin = {107, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceSend annotation(
        Placement(transformation(origin = {147, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackSend annotation(
        Placement(transformation(origin = {187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeSend annotation(
        Placement(transformation(origin = {227, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendEOF(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {247, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofSend annotation(
        Placement(transformation(origin = {267, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength(y = bitCounter.y >= (19 + dataLength)) annotation(
        Placement(transformation(origin = {47, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength(y = bitCounter.y >= (34 + dataLength)) annotation(
        Placement(transformation(origin = {87, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength(y = bitCounter.y >= (35 + dataLength)) annotation(
        Placement(transformation(origin = {127, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength(y = bitCounter.y >= (36 + dataLength)) annotation(
        Placement(transformation(origin = {167, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength(y = bitCounter.y >= (37 + dataLength)) annotation(
        Placement(transformation(origin = {207, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength(y = (bitCounter.y >= (44 + dataLength)) and not sendWaiting) annotation(
        Placement(transformation(origin = {247, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcReceived annotation(
        Placement(transformation(origin = {107, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step ReceiveCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceReveived annotation(
        Placement(transformation(origin = {147, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackReceived annotation(
        Placement(transformation(origin = {187, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeReceived annotation(
        Placement(transformation(origin = {227, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveEOF(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {247, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofReceived annotation(
        Placement(transformation(origin = {267, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = (bitCounter.y >= (44 + dataLength)) and sendWaiting) annotation(
        Placement(transformation(origin = {247, 13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending annotation(
        Placement(transformation(origin = {267, 27}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending1 annotation(
        Placement(transformation(origin = {267, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression toReceive1(y = changeToReceive) annotation(
        Placement(transformation(origin = {-117, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength1(y = bitCounter.y >= (19 + readDataLength)) annotation(
        Placement(transformation(origin = {46, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength1(y = bitCounter.y >= (34 + readDataLength)) annotation(
        Placement(transformation(origin = {86, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength1(y = bitCounter.y >= (35 + readDataLength)) annotation(
        Placement(transformation(origin = {126, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength1(y = bitCounter.y >= (36 + readDataLength)) annotation(
        Placement(transformation(origin = {166, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength1(y = bitCounter.y >= (37 + readDataLength)) annotation(
        Placement(transformation(origin = {206, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength1(y = (bitCounter.y >= (44 + readDataLength)) and not sendWaiting) annotation(
        Placement(transformation(origin = {246, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = (bitCounter.y >= (44 + readDataLength)) and sendWaiting) annotation(
        Placement(transformation(origin = {246, -68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep SYNC_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-205, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ1 annotation(
        Placement(transformation(origin = {-181, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step PROP_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-161, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ2 annotation(
        Placement(transformation(origin = {-139, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ3 annotation(
        Placement(transformation(origin = {-99, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = tQCounter.y >= 1) annotation(
        Placement(transformation(origin = {-201, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = tQCounter.y >= PROP_SEG_TQ + 1) annotation(
        Placement(transformation(origin = {-161, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = tQCounter.y == 0) annotation(
        Placement(transformation(origin = {-119, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal PHASE_SEG2(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-119, -74}, extent = {{-10, -10}, {10, 10}})));
  //======================================================================================
      //======================================================================================
      Modelica.Blocks.Interfaces.BooleanInput sending annotation(
        Placement(transformation(origin = {-260, 66}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 130}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput receiving annotation(
        Placement(transformation(origin = {-260, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput changeToReceive annotation(
        Placement(transformation(origin = {-260, 10}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput noData annotation(
        Placement(transformation(origin = {-260, -20}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput dataLength annotation(
        Placement(transformation(origin = {-260, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput readDataLength annotation(
        Placement(transformation(origin = {-260, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput sendWaiting annotation(
        Placement(transformation(origin = {-260, -110}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -130}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerOutput canCoreState annotation(
        Placement(transformation(origin = {310, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput txPoint annotation(
        Placement(transformation(origin = {310, 10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput rxPoint annotation(
        Placement(transformation(origin = {310, -30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}})));
    initial algorithm
      canCoreState := 1;
    algorithm
      when Idle.active then
        canCoreState := 1;
      end when;
      when Sync.active then
        canCoreState := 2;
      end when;
      when Arb.active then
        canCoreState := 3;
      end when;
      when Receive.active then
        canCoreState := 4;
      end when;
      when SendIDE.active then
        canCoreState := 5;
      end when;
      when Sendr0.active then
        canCoreState := 6;
      end when;
      when SendDLC.active then
        canCoreState := 7;
      end when;
      when ReceiveDLC.active then
        canCoreState := 8;
      end when;
      when SendData.active then
        canCoreState := 9;
      end when;
      when ReceiveData.active then
        canCoreState := 10;
      end when;
      when SendCRC.active then
        canCoreState := 11;
      end when;
      when ReceiveCRC.active then
        canCoreState := 12;
      end when;
      when SendCRCE.active then
        canCoreState := 13;
      end when;
      when ReceiveCRCE.active then
        canCoreState := 14;
      end when;
      when SendACK.active then
        canCoreState := 15;
      end when;
      when ReceiveACK.active then
        canCoreState := 16;
      end when;
      when SendACKE.active then
        canCoreState := 17;
      end when;
      when ReceiveACKE.active then
        canCoreState := 18;
      end when;
      when SendEOF.active then
        canCoreState := 19;
      end when;
      when ReceiveEOF.active then
        canCoreState := 20;
      end when;
      
    equation
      txPoint = (tQCounter.y == 1);
      rxPoint = (tQCounter.y == PROP_SEG_TQ + 1);
      connect(whenRxFalse.y, whenRxLow.condition) annotation(
        Line(points = {{-200, 41}, {-188, 41}, {-188, 55}}, color = {255, 0, 255}));
      connect(Idle.outPort[1], whenRxLow.inPort) annotation(
        Line(points = {{-202.5, 67}, {-190.5, 67}}));
      connect(whenRxLow.outPort, Sync.inPort[1]) annotation(
        Line(points = {{-185.5, 67}, {-177.5, 67}}));
      connect(Sync.active, tQCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-191, 23}, {-191, 18}}, color = {255, 0, 255}));
      connect(Sync.active, tQTimer.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-211, 23}, {-211, 18}}, color = {255, 0, 255}));
      connect(tQTimer.y, tQCounter.count) annotation(
        Line(points = {{-204, 11}, {-198, 11}}, color = {255, 0, 255}));
      connect(Sync.outPort[1], bit1.inPort) annotation(
        Line(points = {{-156.5, 67}, {-143, 67}}));
      connect(whenbit1.y, bit1.condition) annotation(
        Line(points = {{-142, 41}, {-140, 41}, {-140, 55}}, color = {255, 0, 255}));
      connect(bit1.outPort, Arb.inPort[1]) annotation(
        Line(points = {{-137.5, 67}, {-127.5, 67}}));
      connect(tQCounter.y, bitCounter.count) annotation(
        Line(points = {{-184, 11}, {-180, 11}}, color = {255, 127, 0}));
      connect(Arb.outPort[1], toReveive.inPort) annotation(
        Line(points = {{-106.5, 67}, {-102.5, 67}, {-102.5, -13}, {-97, -13}}));
      connect(toReveive.outPort, Receive.inPort[1]) annotation(
        Line(points = {{-91.5, -13}, {-83.5, -13}}));
      connect(Sync.active, bitCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 22}, {-173, 22}, {-173, 18}}, color = {255, 0, 255}));
      connect(Sync.outPort[2], startReceiving.inPort) annotation(
        Line(points = {{-156.5, 67}, {-150.5, 67}, {-150.5, -13}, {-143, -13}}));
      connect(startReceiving.outPort, Receive.inPort[2]) annotation(
        Line(points = {{-137.5, -13}, {-107.5, -13}, {-107.5, -1}, {-87.5, -1}, {-87.5, -13}, {-83.5, -13}}));
      connect(whenBit1AndNotSending.y, startReceiving.condition) annotation(
        Line(points = {{-142, -35}, {-139, -35}, {-139, -25}}, color = {255, 0, 255}));
      connect(Arb.outPort[2], arbSuccess.inPort) annotation(
        Line(points = {{-106.5, 67}, {-96.5, 67}}));
      connect(bitCount13.y, arbSuccess.condition) annotation(
        Line(points = {{-106, 41}, {-94, 41}, {-94, 55}}, color = {255, 0, 255}));
      connect(arbSuccess.outPort, SendIDE.inPort[1]) annotation(
        Line(points = {{-91.5, 67}, {-83.5, 67}}));
      connect(bitCount14.y, ideSend.condition) annotation(
        Line(points = {{-62, 41}, {-54, 41}, {-54, 55}}, color = {255, 0, 255}));
      connect(SendIDE.outPort[1], ideSend.inPort) annotation(
        Line(points = {{-62.5, 67}, {-56.5, 67}}));
      connect(ideSend.outPort, Sendr0.inPort[1]) annotation(
        Line(points = {{-51.5, 67}, {-43.5, 67}}));
      connect(Sendr0.outPort[1], r0Send.inPort) annotation(
        Line(points = {{-22.5, 67}, {-16.5, 67}}));
      connect(SendDLC.outPort[1], dlcSend.inPort) annotation(
        Line(points = {{17.5, 67}, {23.5, 67}}));
      connect(r0Send.outPort, SendDLC.inPort[1]) annotation(
        Line(points = {{-11.5, 67}, {-3.5, 67}}));
      connect(ider0Received.outPort, ReceiveDLC.inPort[1]) annotation(
        Line(points = {{-11.5, -13}, {-3.5, -13}}));
      connect(Receive.outPort[1], ider0Received.inPort) annotation(
        Line(points = {{-62.5, -13}, {-16.5, -13}}));
      connect(ReceiveDLC.outPort[1], dlcReceived.inPort) annotation(
        Line(points = {{17.5, -13}, {23.5, -13}}));
      connect(dlcSend.outPort, SendData.inPort[1]) annotation(
        Line(points = {{28.5, 67}, {36.5, 67}}));
      connect(dlcReceived.outPort, ReceiveData.inPort[1]) annotation(
        Line(points = {{28.5, -13}, {36.5, -13}}));
      connect(SendData.outPort[1], dataSend.inPort) annotation(
        Line(points = {{57.5, 67}, {63.5, 67}}));
      connect(ReceiveData.outPort[1], dataReceived.inPort) annotation(
        Line(points = {{57.5, -13}, {63.5, -13}}));
      connect(dataReceived.outPort, ReceiveCRC.inPort[1]) annotation(
        Line(points = {{68.5, -13}, {76.5, -13}}));
      connect(dataSend.outPort, SendCRC.inPort[1]) annotation(
        Line(points = {{68.5, 67}, {76.5, 67}}));
      connect(noDataSend.outPort, SendCRC.inPort[2]) annotation(
        Line(points = {{68.5, 25}, {71, 25}, {71, 67}, {77, 67}}));
      connect(SendDLC.outPort[2], noDataSend.inPort) annotation(
        Line(points = {{17.5, 67}, {19.5, 67}, {19.5, 25}, {63.5, 25}}));
      connect(bitCount19AndnoData.y, noDataSend.condition) annotation(
        Line(points = {{18, 11}, {58, 11}, {58, 12}, {66, 12}, {66, 13}}, color = {255, 0, 255}));
      connect(bitCount19AndnoData.y, noDataReveive.condition) annotation(
        Line(points = {{18, 11}, {59, 11}, {59, -65}, {67, -65}}, color = {255, 0, 255}));
      connect(ReceiveDLC.outPort[2], noDataReveive.inPort) annotation(
        Line(points = {{17.5, -13}, {19.5, -13}, {19.5, -53}, {63.5, -53}}));
      connect(noDataReveive.outPort, ReceiveCRC.inPort[2]) annotation(
        Line(points = {{68.5, -53}, {71, -53}, {71, -13}, {77, -13}}));
      connect(bitCount19PlusDataLength.y, dataSend.condition) annotation(
        Line(points = {{58, 41}, {62, 41}, {62, 54}, {66, 54}, {66, 55}}, color = {255, 0, 255}));
      connect(SendCRC.outPort[1], crcSend.inPort) annotation(
        Line(points = {{97.5, 67}, {103.5, 67}}));
      connect(crcSend.outPort, SendCRCE.inPort[1]) annotation(
        Line(points = {{108.5, 67}, {116.5, 67}}));
      connect(SendCRCE.outPort[1], crceSend.inPort) annotation(
        Line(points = {{137.5, 67}, {143.5, 67}}));
      connect(crceSend.outPort, SendACK.inPort[1]) annotation(
        Line(points = {{148.5, 67}, {156.5, 67}}));
      connect(SendACK.outPort[1], ackSend.inPort) annotation(
        Line(points = {{177.5, 67}, {183.5, 67}}));
      connect(ackSend.outPort, SendACKE.inPort[1]) annotation(
        Line(points = {{188.5, 67}, {196.5, 67}}));
      connect(SendACKE.outPort[1], ackeSend.inPort) annotation(
        Line(points = {{217.5, 67}, {223.5, 67}}));
      connect(ackeSend.outPort, SendEOF.inPort[1]) annotation(
        Line(points = {{228.5, 67}, {236.5, 67}}));
      connect(SendEOF.outPort[1], eofSend.inPort) annotation(
        Line(points = {{257.5, 67}, {263.5, 67}}));
      connect(bitCount34PlusDataLength.y, crcSend.condition) annotation(
        Line(points = {{98, 41}, {102, 41}, {102, 55}, {106, 55}}, color = {255, 0, 255}));
      connect(bitCount19.y, dlcReceived.condition) annotation(
        Line(points = {{18, 41}, {23, 41}, {23, -25}, {27, -25}}, color = {255, 0, 255}));
      connect(bitCount19.y, dlcSend.condition) annotation(
        Line(points = {{18, 41}, {22, 41}, {22, 55}, {26, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, r0Send.condition) annotation(
        Line(points = {{-22, 41}, {-18, 41}, {-18, 55}, {-14, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, ider0Received.condition) annotation(
        Line(points = {{-22, 41}, {-17, 41}, {-17, -25}, {-13, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength.y, crceSend.condition) annotation(
        Line(points = {{138, 41}, {142, 41}, {142, 55}, {146, 55}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength.y, ackSend.condition) annotation(
        Line(points = {{178, 41}, {182, 41}, {182, 55}, {186, 55}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength.y, ackeSend.condition) annotation(
        Line(points = {{218, 41}, {222, 41}, {222, 55}, {226, 55}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength.y, eofSend.condition) annotation(
        Line(points = {{258, 41}, {262, 41}, {262, 55}, {266, 55}}, color = {255, 0, 255}));
      connect(ReceiveCRC.outPort[1], crcReceived.inPort) annotation(
        Line(points = {{97.5, -13}, {103.5, -13}}));
      connect(crcReceived.outPort, ReceiveCRCE.inPort[1]) annotation(
        Line(points = {{108.5, -13}, {116.5, -13}}));
      connect(ReceiveCRCE.outPort[1], crceReveived.inPort) annotation(
        Line(points = {{137.5, -13}, {143.5, -13}}));
      connect(crceReveived.outPort, ReceiveACK.inPort[1]) annotation(
        Line(points = {{148.5, -13}, {156.5, -13}}));
      connect(ReceiveACK.outPort[1], ackReceived.inPort) annotation(
        Line(points = {{177.5, -13}, {183.5, -13}}));
      connect(ackReceived.outPort, ReceiveACKE.inPort[1]) annotation(
        Line(points = {{188.5, -13}, {196.5, -13}}));
      connect(ReceiveACKE.outPort[1], ackeReceived.inPort) annotation(
        Line(points = {{217.5, -13}, {223.5, -13}}));
      connect(ackeReceived.outPort, ReceiveEOF.inPort[1]) annotation(
        Line(points = {{228.5, -13}, {236.5, -13}}));
      connect(ReceiveEOF.outPort[1], eofReceived.inPort) annotation(
        Line(points = {{257.5, -13}, {263.5, -13}}));
      connect(booleanExpression.y, waitSending.condition) annotation(
        Line(points = {{258, 13}, {260, 13}, {260, 15}, {266, 15}}, color = {255, 0, 255}));
      connect(ReceiveEOF.outPort[2], waitSending1.inPort) annotation(
        Line(points = {{257.5, -13}, {259.5, -13}, {259.5, -53}, {263.5, -53}}));
      connect(SendEOF.outPort[2], waitSending.inPort) annotation(
        Line(points = {{257.5, 67}, {259.5, 67}, {259.5, 27}, {263.5, 27}}));
      connect(eofSend.outPort, Idle.inPort[1]) annotation(
        Line(points = {{268.5, 67}, {280.5, 67}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
      connect(eofReceived.outPort, Idle.inPort[2]) annotation(
        Line(points = {{268.5, -13}, {280.5, -13}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
      connect(waitSending.outPort, Sync.inPort[2]) annotation(
        Line(points = {{268.5, 27}, {272.5, 27}, {272.5, 83}, {-181.5, 83}, {-181.5, 67}, {-177.5, 67}}));
      connect(waitSending1.outPort, Sync.inPort[3]) annotation(
        Line(points = {{268.5, -53}, {273, -53}, {273, 83}, {-181, 83}, {-181, 67}, {-177, 67}}));
      connect(bitCount19PlusDataLength1.y, dataReceived.condition) annotation(
        Line(points = {{57, -40}, {67, -40}, {67, -25}}, color = {255, 0, 255}));
      connect(bitCount34PlusDataLength1.y, crcReceived.condition) annotation(
        Line(points = {{97, -40}, {107, -40}, {107, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength1.y, crceReveived.condition) annotation(
        Line(points = {{137, -40}, {147, -40}, {147, -25}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength1.y, ackReceived.condition) annotation(
        Line(points = {{177, -40}, {187, -40}, {187, -25}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength1.y, ackeReceived.condition) annotation(
        Line(points = {{217, -40}, {227, -40}, {227, -25}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength1.y, eofReceived.condition) annotation(
        Line(points = {{257, -40}, {267, -40}, {267, -25}}, color = {255, 0, 255}));
      connect(booleanExpression4.y, waitSending1.condition) annotation(
        Line(points = {{257, -68}, {267, -68}, {267, -65}}, color = {255, 0, 255}));
      connect(toReceive1.y, toReveive.condition) annotation(
        Line(points = {{-106, -35}, {-94, -35}, {-94, -25}}, color = {255, 0, 255}));
      connect(SYNC_SEG.outPort[1], TQ1.inPort) annotation(
        Line(points = {{-194.5, -74}, {-184.5, -74}}));
      connect(TQ1.outPort, PROP_SEG.inPort[1]) annotation(
        Line(points = {{-179.5, -74}, {-171.5, -74}}));
      connect(PROP_SEG.outPort[1], TQ2.inPort) annotation(
        Line(points = {{-150.5, -74}, {-142.5, -74}}));
      connect(TQ3.outPort, SYNC_SEG.inPort[1]) annotation(
        Line(points = {{-97.5, -74}, {-93.5, -74}, {-93.5, -94}, {-221.5, -94}, {-221.5, -74}, {-215.5, -74}}));
      connect(booleanExpression1.y, TQ1.condition) annotation(
        Line(points = {{-190, -106}, {-182, -106}, {-182, -86}}, color = {255, 0, 255}));
      connect(booleanExpression2.y, TQ2.condition) annotation(
        Line(points = {{-150, -106}, {-140, -106}, {-140, -86}}, color = {255, 0, 255}));
      connect(booleanExpression3.y, TQ3.condition) annotation(
        Line(points = {{-108, -106}, {-100, -106}, {-100, -86}}, color = {255, 0, 255}));
      connect(TQ2.outPort, PHASE_SEG2.inPort[1]) annotation(
        Line(points = {{-137.5, -74}, {-129.5, -74}}));
      connect(PHASE_SEG2.outPort[1], TQ3.inPort) annotation(
        Line(points = {{-108.5, -74}, {-102.5, -74}}));
      annotation(
        Diagram(coordinateSystem(extent = {{-240, 100}, {300, -120}}), graphics),
  Icon(graphics = {Rectangle(origin = {-10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 140}, {70, -140}}), Text(origin = {-10, 150}, extent = {{-70, 10}, {70, -10}}, textString = "%name"), Text(origin = {-51, 130}, extent = {{-29, 10}, {29, -10}}, textString = "sending"), Text(origin = {-51, 90}, extent = {{-29, 10}, {29, -10}}, textString = "receiving"), Text(origin = {-51, 30}, extent = {{-29, 10}, {29, -10}}, textString = "changeToReceive"), Text(origin = {-51, -10}, extent = {{-29, 10}, {29, -10}}, textString = "noData"), Text(origin = {-51, -50}, extent = {{-29, 10}, {29, -10}}, textString = "dataLength"), Text(origin = {-51, -90}, extent = {{-29, 10}, {29, -10}}, textString = "readDataLength"), Text(origin = {-51, -130}, extent = {{-29, 10}, {29, -10}}, textString = "sendWaiting"), Text(origin = {31, 50}, extent = {{-29, 10}, {29, -10}}, textString = "canCoreState"), Text(origin = {31, 10}, extent = {{-29, 10}, {29, -10}}, textString = "txPoint"), Text(origin = {31, -30}, extent = {{-29, 10}, {29, -10}}, textString = "rxPoint")}, coordinateSystem(extent = {{-100, 140}, {80, -140}})),
  Documentation(info = "<html><head></head><body><div>鐘舵€佸涓嬶細</div><ol><li>Idle</li><li>Sync</li><li>Arb</li><li>Receive</li><li>SendIDE</li><li>Sendr0</li><li>SendDLC</li><li>ReceiveDLC</li><li>SendData</li><li>ReceiveData</li><li>SendCRC</li><li>ReceiveCRC</li><li>SendCRCE</li><li>ReceiveCRCE</li><li>SendACK</li><li>ReceiveACK</li><li>SendACKE</li><li>ReceiveACKE</li><li>SendEOF</li><li>ReceiveEOF</li></ol></body></html>"));
end CANCoreStateMech;

    model ReadFromBufferStateMech
  Integer readData[10](start = fill(0, 10));
    Integer i(start = 0);
    Integer dataLength(start = 8);
    Integer frameInfo(start = 8);
    Boolean IDE(start = false);
    Boolean RTR(start = false);
    Boolean DLC[4](start = fill(false, 4));
    Boolean ID[11](start = fill(false, 11));
    Boolean Data[64](start = fill(false, 64));
    Boolean ArbData[12](start = fill(false, 12));
    Boolean CRC[15](start = fill(false, 15));
    Boolean CRCE(start = false);
    Boolean ACK(start = false);
    Boolean ACKE(start = false);
    Boolean EOF[7](start = fill(false, 7));
    Boolean finishReadingFromBuffer(start = false);
    Boolean startSend1(start = false);
    Boolean finishSendingToCAN(start = false);
    Modelica.StateGraph.InitialStep Wait(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-41, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startSendSignal annotation(
        Placement(transformation(origin = {-21, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReadFromBuffer(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-1, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finishReading annotation(
        Placement(transformation(origin = {19, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal sendingFrame(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {39, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finishSendingFrame annotation(
        Placement(transformation(origin = {59, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression startToSend(y = startSend1) annotation(
        Placement(transformation(origin = {-41, -32}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression finishReadingFromBuffer1(y = finishReadingFromBuffer) annotation(
        Placement(transformation(origin = {-1, -32}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression finishSending(y = finishSendingToCAN) annotation(
        Placement(transformation(origin = {39, -32}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
        Placement(transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, 10}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}})));
  //===========================================================
      Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -90}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput finishedSend annotation(
        Placement(transformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    utils.BoolArrayBus boolArrayBus(N=11) annotation(
        Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}})));
    
    
    algorithm
    when clk then
      if ReadFromBuffer.active then
        readTag := true;
      end if;
    end when;
    when not clk then
      if ReadFromBuffer.active then
        i := i + 1;
        readData[i] := readInt;
        readTag := false;
        if i >= dataLength + 2 then
          ID := utils.intToBoolArray(b=readData[1]*8+integer(readData[2]/32), N=11);
          for x in 1:8 loop
            Data[1+8*(x-1):8*x] := utils.intToBoolArray(b=readData[x+2], N=8);
          end for;
          ArbData := cat(1, ID, {RTR});
          CRC := fill(true, 15);
          CRCE := true;
          ACK := true;
          ACKE := true;
          EOF := fill(true, 7);
          finishReadingFromBuffer := true;
        end if;
      end if;
    end when;
    when Wait.active then
      frameInfo := 0;
      IDE := false;
      RTR := false;
      dataLength := 0;
      DLC := fill(false, 4);
      ID := fill(false, 11);
      Data := fill(false, 64);
      readData := fill(0, 10);
      finishSendingToCAN := false;
    end when;
    when ReadFromBuffer.active then
        startSend1 := false;
        i := 0;
        frameInfo := TxFrameInfo;
        IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
        RTR := if frameInfo>=128 then true else false;
        dataLength := mod(frameInfo, 16);
        DLC := utils.intToBoolArray(b=dataLength, N=4);
      end when;
    when sendingFrame.active then
//sendingFrame
      finishReadingFromBuffer := false;
    end when;
    when startSend then
//sendingFrame
      startSend1 := true;
    end when;
    when finishedSend then
//sendingFrame
      finishSendingToCAN := true;
    end when;
//===========================================================
    equation
      boolArrayBus.signal = ID;
      connect(Wait.outPort[1], startSendSignal.inPort) annotation(
        Line(points = {{-30.5, 2}, {-24.5, 2}}));
      connect(startSendSignal.outPort, ReadFromBuffer.inPort[1]) annotation(
        Line(points = {{-19.5, 2}, {-11.5, 2}}));
      connect(ReadFromBuffer.outPort[1], finishReading.inPort) annotation(
        Line(points = {{9.5, 2}, {15.5, 2}}));
      connect(finishReading.outPort, sendingFrame.inPort[1]) annotation(
        Line(points = {{20.5, 2}, {28.5, 2}}));
      connect(sendingFrame.outPort[1], finishSendingFrame.inPort) annotation(
        Line(points = {{49.5, 2}, {55.5, 2}}));
      connect(finishSendingFrame.outPort, Wait.inPort[1]) annotation(
        Line(points = {{60.5, 2}, {68.5, 2}, {68.5, 22}, {-61.5, 22}, {-61.5, 2}, {-51.5, 2}}));
      connect(startToSend.y, startSendSignal.condition) annotation(
        Line(points = {{-30, -32}, {-22, -32}, {-22, -10}}, color = {255, 0, 255}));
      connect(finishReadingFromBuffer1.y, finishReading.condition) annotation(
        Line(points = {{10, -32}, {18, -32}, {18, -10}}, color = {255, 0, 255}));
      connect(finishSending.y, finishSendingFrame.condition) annotation(
        Line(points = {{50, -32}, {58, -32}, {58, -10}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-80, 10}, {80, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startSend"), Text(origin = {-50, 40}, extent = {{-30, 10}, {30, -10}}, textString = "readInt"), Text(origin = {-50, 10}, extent = {{-30, 10}, {30, -10}}, textString = "readTag"), Text(origin = {-50, -20}, extent = {{-30, 10}, {30, -10}}, textString = "TxFrameInfo"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {0, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishedSend")}),
  Diagram(graphics));
end ReadFromBufferStateMech;

algorithm
//杩愯閫昏緫閮ㄥ垎
//=================================================
  when clk.y then
    if ReadFromBuffer.active then
      readTag := true;
    end if;
  end when;
  when not clk.y then
    if ReadFromBuffer.active then
      i := i + 1;
      readData[i] := readInt;
      readTag := false;
      if i >= dataLength + 2 then
        ID := utils.intToBoolArray(b=readData[1]*8+integer(readData[2]/32), N=11);
        for x in 1:8 loop
          Data[1+8*(x-1):8*x] := utils.intToBoolArray(b=readData[x+2], N=8);
        end for;
        ArbData := cat(1, ID, {RTR});
        CRC := fill(true, 15);
        CRCE := true;
        ACK := true;
        ACKE := true;
        EOF := fill(true, 7);
        finishReadingFromBuffer := true;
      end if;
    end if;
  end when;
 
  when sendingFrame.active then
//sendingFrame
    finishReadingFromBuffer := false;
  end when;
//=================================================
    when finishSendingToCAN then
      frameInfo := 0;
      IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
      RTR := false;
      dataLength := 0;
      DLC := fill(false, 4);
      ID := fill(false, 11);
      Data := fill(false, 64);
      readData := fill(0, 10);
    end when;
    when ReadFromBuffer.active then
      sendWaiting := true;
      i := 0;
      frameInfo := TxFrameInfo;
      IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
      RTR := if frameInfo>=128 then true else false;
      dataLength := mod(frameInfo, 16);
      DLC := utils.intToBoolArray(b=dataLength, N=4);
      
    end when;
    
    when Sync.active then
      if sendWaiting and not sending then
        sending := true;
      end if;
    end when;
//=================================================
//鐘舵€侀€昏緫
  when tQCounter.y == 1 then
    if Idle.active then    //绌洪棽鐘舵€?
//do nothing
    elseif Sync.active then//鍚屾鐘舵€?
      Tx := false;    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
    elseif Arb.active then//浠茶鍏煎彂閫佺姸鎬?
      Tx := ArbData[bitCounter.y];    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
    elseif SendIDE.active then//鍙戦€両DE鐘舵€?
      Tx := IDE;    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif Sendr0.active then//鍙戦€乺0鐘舵€?
      Tx := r0;    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif SendDLC.active then//鍙戦€丏LC鐘舵€?
      Tx := DLC[bitCounter.y - 14];    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif Receive.active then    //鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//do nothing
    elseif ReceiveDLC.active then      //鎺ユ敹DLC鐘舵€?
//do nothing
      elseif SendData.active then//鍙戦€丏ata鐘舵€?
      Tx := Data[bitCounter.y - 18];
    elseif ReceiveData.active then      //鎺ユ敹Data鐘舵€?
//do nothing
      elseif SendCRC.active then//鍙戦€丆RC鐘舵€?
      Tx := CRC[bitCounter.y - 18 - dataLength];
    elseif ReceiveCRC.active then      //鎺ユ敹CRC鐘舵€?
//do nothing
      elseif SendCRCE.active then//鍙戦€丆RCE鐘舵€?
        Tx := CRCE;
    elseif ReceiveCRCE.active then      //鎺ユ敹CRCE鐘舵€?
//do nothing
    elseif SendACK.active then//鍙戦€丄CK鐘舵€?
        Tx := true;
    elseif ReceiveACK.active then//鎺ユ敹ACK鐘舵€?
        Tx := false;
    elseif SendACKE.active then//鍙戦€丄CKE鐘舵€?
        Tx := true;
    elseif ReceiveACKE.active then      //鎺ユ敹ACKE鐘舵€?
//do nothing
    elseif SendEOF.active then//鍙戦€丒OF鐘舵€?
        Tx := true;
        if bitCounter.y >= 43+dataLength then
          sending := false;
          sendWaiting := false;
          finishSendingToCAN := true;
        end if;
    elseif ReceiveEOF.active then//鎺ユ敹EOF鐘舵€?
        if bitCounter.y >= 43+readDataLength then
          receiving := false;
          finishreceivingFromCAN := true;
        end if;
    end if;
  end when;
//=========================================================================================================
  when tQCounter.y >= PROP_SEG_TQ + 1 then   
    if Idle.active then    //绌洪棽鐘舵€?
//do nothing
    elseif Sync.active then    //鍚屾鐘舵€?
//do nothing
    elseif Arb.active then//浠茶鍏煎彂閫佺姸鎬?
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鑻x涓洪珮鑰孯x涓轰綆锛屽垯鐩存帴杩涘叆鎺ユ敹閫昏緫
        Record[bitCounter.y] := Rx;
        if Tx and not Rx then
          changeToReceive := true;
          sending := false;
          receiving := true;
        end if;
    elseif SendIDE.active then    //鍙戦€両DE鐘舵€?
//do nothing
    elseif Sendr0.active then  //鍙戦€乺0鐘舵€?
//do nothing
    elseif SendDLC.active then  //鍙戦€丏LC鐘舵€?
//do nothing
    elseif Receive.active then
//鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
        Record[bitCounter.y] := Rx;
    elseif ReceiveDLC.active then      //鎺ユ敹DLC鐘舵€?
        Record[bitCounter.y] := Rx;
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
        dlc_received := dlc_received*2 + utils.boolToInt(Rx);
//璁板綍DLC
        if bitCounter.y >= 18 then
          readDataLength := dlc_received*8;
          frameLength := dlc_received*8 + 44;
//鍥涗釜bit鍚庢洿鏂版暣甯ч暱搴?
          if dlc_received == 0 then
            noData := true;
          else
            noData := false;
          end if;
        end if;
    elseif SendData.active then      //鍙戦€丏ata鐘舵€?
//do nothing
    elseif ReceiveData.active then      //鎺ユ敹Data鐘舵€?
//do nothing
      elseif SendCRC.active then      //鍙戦€丆RC鐘舵€?
//do nothing
    elseif ReceiveCRC.active then      //鎺ユ敹CRC鐘舵€?
        Record[bitCounter.y] := Rx;
        crc_received[bitCounter.y - 18 - readDataLength] := Rx;
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
    elseif SendCRCE.active then      //鍙戦€丆RCE鐘舵€?
//do nothing
    elseif ReceiveCRCE.active then      //鎺ユ敹CRCE鐘舵€?
//do nothing
    elseif SendACK.active then      //鍙戦€丄CK鐘舵€?
//do nothing
    elseif ReceiveACK.active then      //鎺ユ敹ACK鐘舵€?
//do nothing
    elseif SendACKE.active then      //鍙戦€丄CKE鐘舵€?
//do nothing
    elseif ReceiveACKE.active then      //鎺ユ敹ACKE鐘舵€?
//do nothing
    elseif SendEOF.active then      //鍙戦€丒OF鐘舵€?
//do nothing
    elseif ReceiveEOF.active then      //鎺ユ敹EOF鐘舵€?
//do nothing
    end if;
  end when;  
equation
    der(z) = 1;
    connect(whenRxFalse.y, whenRxLow.condition) annotation(
      Line(points = {{-241, 44}, {-229, 44}, {-229, 58}}, color = {255, 0, 255}));
    connect(Idle.outPort[1], whenRxLow.inPort) annotation(
      Line(points = {{-243.5, 70}, {-231.5, 70}}));
    connect(whenRxLow.outPort, Sync.inPort[1]) annotation(
      Line(points = {{-226.5, 70}, {-218.5, 70}}));
    connect(SYNC_SEG.outPort[1], TQ1.inPort) annotation(
      Line(points = {{158.5, -144}, {168.5, -144}}));
    connect(TQ1.outPort, PROP_SEG.inPort[1]) annotation(
      Line(points = {{173.5, -144}, {181.5, -144}}));
    connect(PROP_SEG.outPort[1], TQ2.inPort) annotation(
      Line(points = {{202.5, -144}, {210.5, -144}}));
    connect(TQ3.outPort, SYNC_SEG.inPort[1]) annotation(
      Line(points = {{255.5, -144}, {259.5, -144}, {259.5, -164}, {131.5, -164}, {131.5, -144}, {137.5, -144}}));
    connect(booleanExpression1.y, TQ1.condition) annotation(
      Line(points = {{163, -176}, {171, -176}, {171, -156}}, color = {255, 0, 255}));
    connect(booleanExpression2.y, TQ2.condition) annotation(
      Line(points = {{203, -176}, {213, -176}, {213, -156}}, color = {255, 0, 255}));
    connect(booleanExpression3.y, TQ3.condition) annotation(
      Line(points = {{245, -176}, {253, -176}, {253, -156}}, color = {255, 0, 255}));
    connect(TQ2.outPort, PHASE_SEG2.inPort[1]) annotation(
      Line(points = {{215.5, -144}, {223.5, -144}}));
    connect(PHASE_SEG2.outPort[1], TQ3.inPort) annotation(
      Line(points = {{244.5, -144}, {250.5, -144}}));
    connect(Sync.active, tQCounter.reset) annotation(
      Line(points = {{-208, 59}, {-208, 26}, {-232, 26}, {-232, 21}}, color = {255, 0, 255}));
    connect(Sync.active, tQTimer.reset) annotation(
      Line(points = {{-208, 59}, {-208, 26}, {-252, 26}, {-252, 21}}, color = {255, 0, 255}));
    connect(tQTimer.y, tQCounter.count) annotation(
      Line(points = {{-245, 14}, {-239, 14}}, color = {255, 0, 255}));
    connect(Sync.outPort[1], bit1.inPort) annotation(
      Line(points = {{-197.5, 70}, {-184, 70}}));
    connect(whenbit1.y, bit1.condition) annotation(
      Line(points = {{-183, 44}, {-181, 44}, {-181, 58}}, color = {255, 0, 255}));
    connect(bit1.outPort, Arb.inPort[1]) annotation(
      Line(points = {{-178.5, 70}, {-168.5, 70}}));
    connect(tQCounter.y, bitCounter.count) annotation(
      Line(points = {{-225, 14}, {-221, 14}}, color = {255, 127, 0}));
    connect(Arb.outPort[1], toReveive.inPort) annotation(
      Line(points = {{-147.5, 70}, {-143.5, 70}, {-143.5, -10}, {-138, -10}}));
    connect(toReveive.outPort, Receive.inPort[1]) annotation(
      Line(points = {{-132.5, -10}, {-124.5, -10}}));
    connect(Sync.active, bitCounter.reset) annotation(
      Line(points = {{-208, 59}, {-208, 25}, {-214, 25}, {-214, 21}}, color = {255, 0, 255}));
    connect(Sync.outPort[2], startReceiving.inPort) annotation(
      Line(points = {{-197.5, 70}, {-191.5, 70}, {-191.5, -10}, {-184, -10}}));
    connect(startReceiving.outPort, Receive.inPort[2]) annotation(
      Line(points = {{-178.5, -10}, {-148.5, -10}, {-148.5, 2}, {-128.5, 2}, {-128.5, -10}, {-124.5, -10}}));
    connect(whenBit1AndNotSending.y, startReceiving.condition) annotation(
      Line(points = {{-183, -32}, {-180, -32}, {-180, -22}}, color = {255, 0, 255}));
    connect(Arb.outPort[2], arbSuccess.inPort) annotation(
      Line(points = {{-147.5, 70}, {-137.5, 70}}));
    connect(bitCount13.y, arbSuccess.condition) annotation(
      Line(points = {{-147, 44}, {-135, 44}, {-135, 58}}, color = {255, 0, 255}));
    connect(arbSuccess.outPort, SendIDE.inPort[1]) annotation(
      Line(points = {{-132.5, 70}, {-124.5, 70}}));
    connect(bitCount14.y, ideSend.condition) annotation(
      Line(points = {{-103, 44}, {-95, 44}, {-95, 58}}, color = {255, 0, 255}));
    connect(SendIDE.outPort[1], ideSend.inPort) annotation(
      Line(points = {{-103.5, 70}, {-97.5, 70}}));
    connect(ideSend.outPort, Sendr0.inPort[1]) annotation(
      Line(points = {{-92.5, 70}, {-84.5, 70}}));
    connect(Sendr0.outPort[1], r0Send.inPort) annotation(
      Line(points = {{-63.5, 70}, {-57.5, 70}}));
    connect(SendDLC.outPort[1], dlcSend.inPort) annotation(
      Line(points = {{-23.5, 70}, {-17.5, 70}}));
    connect(r0Send.outPort, SendDLC.inPort[1]) annotation(
      Line(points = {{-52.5, 70}, {-44.5, 70}}));
    connect(ider0Received.outPort, ReceiveDLC.inPort[1]) annotation(
      Line(points = {{-52.5, -10}, {-44.5, -10}}));
    connect(Receive.outPort[1], ider0Received.inPort) annotation(
      Line(points = {{-103.5, -10}, {-57.5, -10}}));
    connect(ReceiveDLC.outPort[1], dlcReceived.inPort) annotation(
      Line(points = {{-23.5, -10}, {-17.5, -10}}));
    connect(dlcSend.outPort, SendData.inPort[1]) annotation(
      Line(points = {{-12.5, 70}, {-4.5, 70}}));
    connect(dlcReceived.outPort, ReceiveData.inPort[1]) annotation(
      Line(points = {{-12.5, -10}, {-4.5, -10}}));
    connect(SendData.outPort[1], dataSend.inPort) annotation(
      Line(points = {{16.5, 70}, {22.5, 70}}));
    connect(ReceiveData.outPort[1], dataReceived.inPort) annotation(
      Line(points = {{16.5, -10}, {22.5, -10}}));
    connect(dataReceived.outPort, ReceiveCRC.inPort[1]) annotation(
      Line(points = {{27.5, -10}, {35.5, -10}}));
    connect(dataSend.outPort, SendCRC.inPort[1]) annotation(
      Line(points = {{27.5, 70}, {35.5, 70}}));
    connect(noDataSend.outPort, SendCRC.inPort[2]) annotation(
      Line(points = {{27.5, 28}, {30, 28}, {30, 70}, {36, 70}}));
    connect(SendDLC.outPort[2], noDataSend.inPort) annotation(
      Line(points = {{-23.5, 70}, {-21.5, 70}, {-21.5, 28}, {22.5, 28}}));
    connect(bitCount19AndnoData.y, noDataSend.condition) annotation(
      Line(points = {{-23, 14}, {17, 14}, {17, 15}, {25, 15}, {25, 16}}, color = {255, 0, 255}));
    connect(bitCount19AndnoData.y, noDataReveive.condition) annotation(
      Line(points = {{-23, 14}, {18, 14}, {18, -62}, {26, -62}}, color = {255, 0, 255}));
    connect(ReceiveDLC.outPort[2], noDataReveive.inPort) annotation(
      Line(points = {{-24, -10}, {-22, -10}, {-22, -50}, {22, -50}}));
    connect(noDataReveive.outPort, ReceiveCRC.inPort[2]) annotation(
      Line(points = {{27.5, -50}, {30, -50}, {30, -10}, {36, -10}}));
    connect(bitCount19PlusDataLength.y, dataSend.condition) annotation(
      Line(points = {{17, 44}, {21, 44}, {21, 57}, {25, 57}, {25, 58}}, color = {255, 0, 255}));
    connect(SendCRC.outPort[1], crcSend.inPort) annotation(
      Line(points = {{56.5, 70}, {62.5, 70}}));
    connect(crcSend.outPort, SendCRCE.inPort[1]) annotation(
      Line(points = {{67.5, 70}, {75.5, 70}}));
    connect(SendCRCE.outPort[1], crceSend.inPort) annotation(
      Line(points = {{96.5, 70}, {102.5, 70}}));
    connect(crceSend.outPort, SendACK.inPort[1]) annotation(
      Line(points = {{107.5, 70}, {115.5, 70}}));
    connect(SendACK.outPort[1], ackSend.inPort) annotation(
      Line(points = {{136.5, 70}, {142.5, 70}}));
    connect(ackSend.outPort, SendACKE.inPort[1]) annotation(
      Line(points = {{147.5, 70}, {155.5, 70}}));
    connect(SendACKE.outPort[1], ackeSend.inPort) annotation(
      Line(points = {{176.5, 70}, {182.5, 70}}));
    connect(ackeSend.outPort, SendEOF.inPort[1]) annotation(
      Line(points = {{187.5, 70}, {195.5, 70}}));
    connect(SendEOF.outPort[1], eofSend.inPort) annotation(
      Line(points = {{216.5, 70}, {222.5, 70}}));
    connect(bitCount34PlusDataLength.y, crcSend.condition) annotation(
      Line(points = {{57, 44}, {61, 44}, {61, 58}, {65, 58}}, color = {255, 0, 255}));
    connect(bitCount19.y, dlcReceived.condition) annotation(
      Line(points = {{-23, 44}, {-18, 44}, {-18, -22}, {-14, -22}}, color = {255, 0, 255}));
    connect(bitCount19.y, dlcSend.condition) annotation(
      Line(points = {{-23, 44}, {-19, 44}, {-19, 58}, {-15, 58}}, color = {255, 0, 255}));
    connect(bitCount15.y, r0Send.condition) annotation(
      Line(points = {{-63, 44}, {-59, 44}, {-59, 58}, {-55, 58}}, color = {255, 0, 255}));
    connect(bitCount15.y, ider0Received.condition) annotation(
      Line(points = {{-63, 44}, {-58, 44}, {-58, -22}, {-54, -22}}, color = {255, 0, 255}));
    connect(bitCount35PlusDataLength.y, crceSend.condition) annotation(
      Line(points = {{97, 44}, {101, 44}, {101, 58}, {105, 58}}, color = {255, 0, 255}));
    connect(bitCount36PlusDataLength.y, ackSend.condition) annotation(
      Line(points = {{137, 44}, {141, 44}, {141, 58}, {145, 58}}, color = {255, 0, 255}));
    connect(bitCount37PlusDataLength.y, ackeSend.condition) annotation(
      Line(points = {{177, 44}, {181, 44}, {181, 58}, {185, 58}}, color = {255, 0, 255}));
    connect(bitCount44PlusDataLength.y, eofSend.condition) annotation(
      Line(points = {{217, 44}, {221, 44}, {221, 58}, {225, 58}}, color = {255, 0, 255}));
    connect(ReceiveCRC.outPort[1], crcReceived.inPort) annotation(
      Line(points = {{56, -10}, {62, -10}}));
    connect(crcReceived.outPort, ReceiveCRCE.inPort[1]) annotation(
      Line(points = {{68, -10}, {76, -10}}));
    connect(ReceiveCRCE.outPort[1], crceReveived.inPort) annotation(
      Line(points = {{96, -10}, {102, -10}}));
    connect(crceReveived.outPort, ReceiveACK.inPort[1]) annotation(
      Line(points = {{108, -10}, {116, -10}}));
    connect(ReceiveACK.outPort[1], ackReceived.inPort) annotation(
      Line(points = {{136, -10}, {142, -10}}));
    connect(ackReceived.outPort, ReceiveACKE.inPort[1]) annotation(
      Line(points = {{148, -10}, {156, -10}}));
    connect(ReceiveACKE.outPort[1], ackeReceived.inPort) annotation(
      Line(points = {{176, -10}, {182, -10}}));
    connect(ackeReceived.outPort, ReceiveEOF.inPort[1]) annotation(
      Line(points = {{188, -10}, {196, -10}}));
    connect(ReceiveEOF.outPort[1], eofReceived.inPort) annotation(
      Line(points = {{216, -10}, {222, -10}}));
    connect(booleanExpression.y, waitSending.condition) annotation(
      Line(points = {{218, 16}, {220, 16}, {220, 18}, {226, 18}}, color = {255, 0, 255}));
    connect(ReceiveEOF.outPort[2], waitSending1.inPort) annotation(
      Line(points = {{216, -10}, {218, -10}, {218, -50}, {222, -50}}));
    connect(SendEOF.outPort[2], waitSending.inPort) annotation(
      Line(points = {{216, 70}, {218, 70}, {218, 30}, {222, 30}}));
    connect(eofSend.outPort, Idle.inPort[1]) annotation(
      Line(points = {{228, 70}, {240, 70}, {240, 90}, {-272, 90}, {-272, 70}, {-264, 70}}));
    connect(eofReceived.outPort, Idle.inPort[2]) annotation(
      Line(points = {{228, -10}, {240, -10}, {240, 90}, {-272, 90}, {-272, 70}, {-264, 70}}));
    connect(waitSending.outPort, Sync.inPort[2]) annotation(
      Line(points = {{228, 30}, {232, 30}, {232, 86}, {-222, 86}, {-222, 70}, {-218, 70}}));
    connect(waitSending1.outPort, Sync.inPort[3]) annotation(
      Line(points = {{227.5, -50}, {232, -50}, {232, 86}, {-222, 86}, {-222, 70}, {-218, 70}}));
    connect(Wait.outPort[1], startSendSignal.inPort) annotation(
      Line(points = {{-220, -90}, {-214, -90}}));
    connect(startSendSignal.outPort, ReadFromBuffer.inPort[1]) annotation(
      Line(points = {{-208, -90}, {-200, -90}}));
    connect(ReadFromBuffer.outPort[1], finishReading.inPort) annotation(
      Line(points = {{-180, -90}, {-174, -90}}));
    connect(finishReading.outPort, sendingFrame.inPort[1]) annotation(
      Line(points = {{-168, -90}, {-160, -90}}));
    connect(sendingFrame.outPort[1], finishSendingFrame.inPort) annotation(
      Line(points = {{-140, -90}, {-134, -90}}));
    connect(finishSendingFrame.outPort, Wait.inPort[1]) annotation(
      Line(points = {{-128, -90}, {-120, -90}, {-120, -70}, {-250, -70}, {-250, -90}, {-240, -90}}));
    connect(startToSend.y, startSendSignal.condition) annotation(
      Line(points = {{-218, -124}, {-210, -124}, {-210, -102}}, color = {255, 0, 255}));
    connect(bitCount19PlusDataLength1.y, dataReceived.condition) annotation(
      Line(points = {{16, -37}, {26, -37}, {26, -22}}, color = {255, 0, 255}));
    connect(bitCount34PlusDataLength1.y, crcReceived.condition) annotation(
      Line(points = {{56, -37}, {66, -37}, {66, -22}}, color = {255, 0, 255}));
    connect(bitCount35PlusDataLength1.y, crceReveived.condition) annotation(
      Line(points = {{96, -37}, {106, -37}, {106, -22}}, color = {255, 0, 255}));
    connect(bitCount36PlusDataLength1.y, ackReceived.condition) annotation(
      Line(points = {{136, -37}, {146, -37}, {146, -22}}, color = {255, 0, 255}));
    connect(bitCount37PlusDataLength1.y, ackeReceived.condition) annotation(
      Line(points = {{176, -37}, {186, -37}, {186, -22}}, color = {255, 0, 255}));
    connect(bitCount44PlusDataLength1.y, eofReceived.condition) annotation(
      Line(points = {{216, -37}, {226, -37}, {226, -22}}, color = {255, 0, 255}));
    connect(booleanExpression4.y, waitSending1.condition) annotation(
      Line(points = {{216, -65}, {226, -65}, {226, -62}}, color = {255, 0, 255}));
    connect(finishReadingFromBuffer1.y, finishReading.condition) annotation(
      Line(points = {{-178, -124}, {-170, -124}, {-170, -102}}, color = {255, 0, 255}));
    connect(finishSending.y, finishSendingFrame.condition) annotation(
      Line(points = {{-138, -124}, {-130, -124}, {-130, -102}}, color = {255, 0, 255}));
  connect(toReceive1.y, toReveive.condition) annotation(
      Line(points = {{-146, -32}, {-134, -32}, {-134, -22}}, color = {255, 0, 255}));
    annotation(
      Icon(graphics = {Rectangle(fillColor = {85, 85, 0}, fillPattern = FillPattern.Horizontal, extent = {{-80, 80}, {80, -80}}), Text(origin = {70, 30}, extent = {{-10, 10}, {10, -10}}, textString = "Tx"), Text(origin = {70, -30}, extent = {{-10, 10}, {10, -10}}, textString = "Rx"), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-40, 71}, extent = {{-40, 9}, {40, -9}}, textString = "startSend"), Text(origin = {-40, 51}, extent = {{-40, 9}, {40, -9}}, textString = "TxFrameInfo"), Text(origin = {-40, -49}, extent = {{-40, 9}, {40, -9}}, textString = "readTag"), Text(origin = {-40, -69}, extent = {{-40, 9}, {40, -9}}, textString = "readInt")}),
      Diagram(graphics = {Rectangle(origin = {20, -60}, extent = {{-300, 160}, {300, -160}})}, coordinateSystem(extent = {{-320, 100}, {320, -220}})));
  end CANCore;

  package utils
      function boolToInt
      input Boolean b;
      output Integer x;
    algorithm
      x := if b then 1 else 0;
    end boolToInt;

    function intToBoolArray
    input Integer b;
    input Integer N;
    output Boolean x[N];
    protected
      Integer temp(start = 0);
    algorithm
      temp := b;
      for i in 1:N loop
        x[i] := if temp >= integer(2^(N-i)) then true else false;
        temp := if x[i] then temp-integer(2^(N-i)) else temp;
      end for;
      
    end intToBoolArray;

    function fillData
    input Integer N[8];
    output Boolean x[64];
    algorithm
  for i in 1:8 loop
        x[1+8*(i-1):8*i] := intToBoolArray(b=N[i], N=8);
      end for;
    end fillData;

    function canCRC15
      input Boolean bits[:];
      input Integer bitLength;
      output Boolean crc[15];
    protected
      Boolean reg[15];
      Boolean feedback;
    algorithm
      reg := fill(false, 15);
      for i in 1:bitLength loop
        feedback := bits[i] <> reg[1];
        reg[1] := reg[2];
        reg[2] := reg[3];
        reg[3] := reg[4] <> feedback;
        reg[4] := reg[5];
        reg[5] := reg[6];
        reg[6] := reg[7];
        reg[7] := reg[8] <> feedback;
        reg[8] := reg[9] <> feedback;
        reg[9] := reg[10];
        reg[10] := reg[11] <> feedback;
        reg[11] := reg[12] <> feedback;
        reg[12] := reg[13];
        reg[13] := reg[14];
        reg[14] := reg[15];
        reg[15] := feedback;
      end for;
      crc := reg;
    end canCRC15;

    connector BoolArrayBus
    parameter Integer N;
  output Boolean signal[N];
      annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}})}));
    end BoolArrayBus;

    connector BoolArrayBusInput
    parameter Integer N;
    input Boolean signal[N];annotation(
        Icon(graphics = {Polygon(fillColor = {255, 0, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{100, 0}, {-100, 100}, {-100, -100}, {100, 0}, {100, 0}})}));
    end BoolArrayBusInput;

    record BoolBundle
      Boolean ArbData[12];
      Boolean ID[11];
      Boolean DLC[4];
      Boolean Data[64];
    end BoolBundle;

    function boolArrayToInt
    input Integer N;
    input Boolean x[N];
    output Integer y(start = 0,fixed = true);
    algorithm
      y := 0;
    for i in 1:N loop
        y := if x[i] then y * 2 + 1 else y * 2;
      end for;
    end boolArrayToInt;
  end utils;

  model CANCore2
    
    
    model RxSampler
      extends Modelica.Blocks.Icons.DiscreteBlock;
      parameter Boolean y_start = true "Initial value of output signal";
      Modelica.Blocks.Interfaces.BooleanInput u "Connector with a Boolean input signal" annotation(
        Placement(transformation(origin = {0, 60}, extent = {{-140, -20}, {-100, 20}}), iconTransformation(origin = {0, 64}, extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y "Connector with a Boolean output signal" annotation(
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger input" annotation(
        Placement(transformation(origin = {0, -118}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanInput v annotation(
        Placement(transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}})));
    equation
      when trigger then
        y = (u and not v) or (v and not u);
      end when;
    initial equation
      y = y_start;
    end RxSampler;
  
    model TQCounter
      parameter Integer N_tq = 16;
      Modelica.Blocks.Interfaces.BooleanInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      when y >= N_tq then
        y := 0;
      end when;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%N_tq")}));
    end TQCounter;
  
    model TQTimer
      parameter Real TQ = 1;
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Real x(start = 0);
    equation
      der(x) = 1;
      when reset then
        reinit(x, 0);
      end when;
      when x >= TQ then
        reinit(x, 0);
      end when;
      y = x < TQ/2;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%TQ")}));
    end TQTimer;
  
    model BitCounter
      Modelica.Blocks.Interfaces.IntegerInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count == 0 then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})),
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name")}));
    end BitCounter;
  
    
  
    model CANCoreStateMech
    //========================================================================
    parameter Real T_Q = 1;
    parameter Integer N_tq = 16;
    parameter Integer PROP_SEG_TQ = 7;
    //========================================================================
  Modelica.StateGraph.InitialStep Idle(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-213, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal whenRxLow annotation(
        Placement(transformation(origin = {-187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenRxFalse(y =  sending or receiving) annotation(
        Placement(transformation(origin = {-211, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sync(nIn = 3, nOut = 2) annotation(
        Placement(transformation(origin = {-167, 67}, extent = {{-10, -10}, {10, 10}})));
  BitCounter bitCounter annotation(
        Placement(transformation(origin = {-173, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal bit1 annotation(
        Placement(transformation(origin = {-139, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenbit1(y = (tQCounter.y >= N_tq - 1) and sending) annotation(
        Placement(transformation(origin = {-153, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Arb(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {-117, 67}, extent = {{-10, -10}, {10, 10}})));
  TQCounter tQCounter(N_tq = N_tq) annotation(
        Placement(transformation(origin = {-191, 11}, extent = {{-10, -10}, {10, 10}})));
  TQTimer tQTimer(TQ = T_Q) annotation(
        Placement(transformation(origin = {-211, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Receive(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-73, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal toReveive annotation(
        Placement(transformation(origin = {-93, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startReceiving annotation(
        Placement(transformation(origin = {-139, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenBit1AndNotSending(y = (tQCounter.y >= N_tq - 1) and not sending) annotation(
        Placement(transformation(origin = {-153, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal arbSuccess annotation(
        Placement(transformation(origin = {-93, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount13(y = (bitCounter.y >= 13) and sending) annotation(
        Placement(transformation(origin = {-117, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendIDE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-73, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ideSend annotation(
        Placement(transformation(origin = {-53, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount14(y = bitCounter.y >= 14) annotation(
        Placement(transformation(origin = {-73, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sendr0(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-33, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount15(y = bitCounter.y >= 15) annotation(
        Placement(transformation(origin = {-33, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal r0Send annotation(
        Placement(transformation(origin = {-13, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcSend annotation(
        Placement(transformation(origin = {27, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19(y = (bitCounter.y >= 19) and not noData) annotation(
        Placement(transformation(origin = {7, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ider0Received annotation(
        Placement(transformation(origin = {-13, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcReceived annotation(
        Placement(transformation(origin = {27, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataSend annotation(
        Placement(transformation(origin = {67, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataReceived annotation(
        Placement(transformation(origin = {67, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataSend annotation(
        Placement(transformation(origin = {67, 25}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndnoData(y = (bitCounter.y >= 19) and noData) annotation(
        Placement(transformation(origin = {7, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataReveive annotation(
        Placement(transformation(origin = {67, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcSend annotation(
        Placement(transformation(origin = {107, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceSend annotation(
        Placement(transformation(origin = {147, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackSend annotation(
        Placement(transformation(origin = {187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeSend annotation(
        Placement(transformation(origin = {227, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendEOF(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {247, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofSend annotation(
        Placement(transformation(origin = {267, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength(y = bitCounter.y >= (19 + dataLength*8)) annotation(
        Placement(transformation(origin = {47, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength(y = bitCounter.y >= (34 + dataLength*8)) annotation(
        Placement(transformation(origin = {87, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength(y = bitCounter.y >= (35 + dataLength*8)) annotation(
        Placement(transformation(origin = {127, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength(y = bitCounter.y >= (36 + dataLength*8)) annotation(
        Placement(transformation(origin = {167, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength(y = bitCounter.y >= (37 + dataLength*8)) annotation(
        Placement(transformation(origin = {207, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength(y = (bitCounter.y >= (44 + dataLength*8)) and not sendWaiting) annotation(
        Placement(transformation(origin = {247, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcReceived annotation(
        Placement(transformation(origin = {107, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step ReceiveCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceReveived annotation(
        Placement(transformation(origin = {147, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackReceived annotation(
        Placement(transformation(origin = {187, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeReceived annotation(
        Placement(transformation(origin = {227, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveEOF(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {247, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofReceived annotation(
        Placement(transformation(origin = {267, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = (bitCounter.y >= (44 + dataLength*8)) and sendWaiting) annotation(
        Placement(transformation(origin = {247, 13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending annotation(
        Placement(transformation(origin = {267, 27}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending1 annotation(
        Placement(transformation(origin = {267, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression toReceive1(y = changeToReceive) annotation(
        Placement(transformation(origin = {-117, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength1(y = bitCounter.y >= (19 + readDataLength)) annotation(
        Placement(transformation(origin = {46, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength1(y = bitCounter.y >= (34 + readDataLength)) annotation(
        Placement(transformation(origin = {86, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength1(y = bitCounter.y >= (35 + readDataLength)) annotation(
        Placement(transformation(origin = {126, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength1(y = bitCounter.y >= (36 + readDataLength)) annotation(
        Placement(transformation(origin = {166, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength1(y = bitCounter.y >= (37 + readDataLength)) annotation(
        Placement(transformation(origin = {206, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength1(y = (bitCounter.y >= (44 + readDataLength)) and not sendWaiting) annotation(
        Placement(transformation(origin = {246, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = (bitCounter.y >= (44 + readDataLength)) and sendWaiting) annotation(
        Placement(transformation(origin = {246, -68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep SYNC_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-205, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ1 annotation(
        Placement(transformation(origin = {-181, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step PROP_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-161, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ2 annotation(
        Placement(transformation(origin = {-139, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ3 annotation(
        Placement(transformation(origin = {-99, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = tQCounter.y >= 1) annotation(
        Placement(transformation(origin = {-201, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = tQCounter.y >= PROP_SEG_TQ + 1) annotation(
        Placement(transformation(origin = {-161, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = tQCounter.y == 0) annotation(
        Placement(transformation(origin = {-119, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal PHASE_SEG2(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-119, -74}, extent = {{-10, -10}, {10, 10}})));
  //======================================================================================
      //======================================================================================
    input Integer dataLength;
    input Integer readDataLength;
    Modelica.Blocks.Interfaces.BooleanInput sending annotation(
        Placement(transformation(origin = {-260, 66}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 130}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput receiving annotation(
        Placement(transformation(origin = {-260, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput changeToReceive annotation(
        Placement(transformation(origin = {-260, 10}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput noData annotation(
        Placement(transformation(origin = {-260, -20}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput sendWaiting annotation(
        Placement(transformation(origin = {-260, -110}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -130}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerOutput canCoreState annotation(
        Placement(transformation(origin = {310, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput txPoint annotation(
        Placement(transformation(origin = {310, 10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput rxPoint annotation(
        Placement(transformation(origin = {310, -30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerOutput bitCounting annotation(
        Placement(transformation(origin = {310, -82}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}})));
    initial algorithm
      canCoreState := 1;
    algorithm
      when Idle.active then
        canCoreState := 1;
      end when;
      when Sync.active then
        canCoreState := 2;
      end when;
      when Arb.active then
        canCoreState := 3;
      end when;
      when Receive.active then
        canCoreState := 4;
      end when;
      when SendIDE.active then
        canCoreState := 5;
      end when;
      when Sendr0.active then
        canCoreState := 6;
      end when;
      when SendDLC.active then
        canCoreState := 7;
      end when;
      when ReceiveDLC.active then
        canCoreState := 8;
      end when;
      when SendData.active then
        canCoreState := 9;
      end when;
      when ReceiveData.active then
        canCoreState := 10;
      end when;
      when SendCRC.active then
        canCoreState := 11;
      end when;
      when ReceiveCRC.active then
        canCoreState := 12;
      end when;
      when SendCRCE.active then
        canCoreState := 13;
      end when;
      when ReceiveCRCE.active then
        canCoreState := 14;
      end when;
      when SendACK.active then
        canCoreState := 15;
      end when;
      when ReceiveACK.active then
        canCoreState := 16;
      end when;
      when SendACKE.active then
        canCoreState := 17;
      end when;
      when ReceiveACKE.active then
        canCoreState := 18;
      end when;
      when SendEOF.active then
        canCoreState := 19;
      end when;
      when ReceiveEOF.active then
        canCoreState := 20;
      end when;
      
    equation
      txPoint = (tQCounter.y == 1);
      rxPoint = (tQCounter.y == PROP_SEG_TQ + 1);
      connect(whenRxFalse.y, whenRxLow.condition) annotation(
        Line(points = {{-200, 41}, {-188, 41}, {-188, 55}}, color = {255, 0, 255}));
      connect(Idle.outPort[1], whenRxLow.inPort) annotation(
        Line(points = {{-202.5, 67}, {-190.5, 67}}));
      connect(whenRxLow.outPort, Sync.inPort[1]) annotation(
        Line(points = {{-185.5, 67}, {-177.5, 67}}));
      connect(Sync.active, tQCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-191, 23}, {-191, 18}}, color = {255, 0, 255}));
      connect(Sync.active, tQTimer.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-211, 23}, {-211, 18}}, color = {255, 0, 255}));
      connect(tQTimer.y, tQCounter.count) annotation(
        Line(points = {{-204, 11}, {-198, 11}}, color = {255, 0, 255}));
      connect(Sync.outPort[1], bit1.inPort) annotation(
        Line(points = {{-156.5, 67}, {-143, 67}}));
      connect(whenbit1.y, bit1.condition) annotation(
        Line(points = {{-142, 41}, {-140, 41}, {-140, 55}}, color = {255, 0, 255}));
      connect(bit1.outPort, Arb.inPort[1]) annotation(
        Line(points = {{-137.5, 67}, {-127.5, 67}}));
      connect(tQCounter.y, bitCounter.count) annotation(
        Line(points = {{-184, 11}, {-180, 11}}, color = {255, 127, 0}));
      connect(Arb.outPort[1], toReveive.inPort) annotation(
        Line(points = {{-106.5, 67}, {-102.5, 67}, {-102.5, -13}, {-97, -13}}));
      connect(toReveive.outPort, Receive.inPort[1]) annotation(
        Line(points = {{-91.5, -13}, {-83.5, -13}}));
      connect(Sync.active, bitCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 22}, {-173, 22}, {-173, 18}}, color = {255, 0, 255}));
      connect(Sync.outPort[2], startReceiving.inPort) annotation(
        Line(points = {{-156.5, 67}, {-150.5, 67}, {-150.5, -13}, {-143, -13}}));
      connect(startReceiving.outPort, Receive.inPort[2]) annotation(
        Line(points = {{-137.5, -13}, {-107.5, -13}, {-107.5, -1}, {-87.5, -1}, {-87.5, -13}, {-83.5, -13}}));
      connect(whenBit1AndNotSending.y, startReceiving.condition) annotation(
        Line(points = {{-142, -35}, {-139, -35}, {-139, -25}}, color = {255, 0, 255}));
      connect(Arb.outPort[2], arbSuccess.inPort) annotation(
        Line(points = {{-106.5, 67}, {-96.5, 67}}));
      connect(bitCount13.y, arbSuccess.condition) annotation(
        Line(points = {{-106, 41}, {-94, 41}, {-94, 55}}, color = {255, 0, 255}));
      connect(arbSuccess.outPort, SendIDE.inPort[1]) annotation(
        Line(points = {{-91.5, 67}, {-83.5, 67}}));
      connect(bitCount14.y, ideSend.condition) annotation(
        Line(points = {{-62, 41}, {-54, 41}, {-54, 55}}, color = {255, 0, 255}));
      connect(SendIDE.outPort[1], ideSend.inPort) annotation(
        Line(points = {{-62.5, 67}, {-56.5, 67}}));
      connect(ideSend.outPort, Sendr0.inPort[1]) annotation(
        Line(points = {{-51.5, 67}, {-43.5, 67}}));
      connect(Sendr0.outPort[1], r0Send.inPort) annotation(
        Line(points = {{-22.5, 67}, {-16.5, 67}}));
      connect(SendDLC.outPort[1], dlcSend.inPort) annotation(
        Line(points = {{17.5, 67}, {23.5, 67}}));
      connect(r0Send.outPort, SendDLC.inPort[1]) annotation(
        Line(points = {{-11.5, 67}, {-3.5, 67}}));
      connect(ider0Received.outPort, ReceiveDLC.inPort[1]) annotation(
        Line(points = {{-11.5, -13}, {-3.5, -13}}));
      connect(Receive.outPort[1], ider0Received.inPort) annotation(
        Line(points = {{-62.5, -13}, {-16.5, -13}}));
      connect(ReceiveDLC.outPort[1], dlcReceived.inPort) annotation(
        Line(points = {{17.5, -13}, {23.5, -13}}));
      connect(dlcSend.outPort, SendData.inPort[1]) annotation(
        Line(points = {{28.5, 67}, {36.5, 67}}));
      connect(dlcReceived.outPort, ReceiveData.inPort[1]) annotation(
        Line(points = {{28.5, -13}, {36.5, -13}}));
      connect(SendData.outPort[1], dataSend.inPort) annotation(
        Line(points = {{57.5, 67}, {63.5, 67}}));
      connect(ReceiveData.outPort[1], dataReceived.inPort) annotation(
        Line(points = {{57.5, -13}, {63.5, -13}}));
      connect(dataReceived.outPort, ReceiveCRC.inPort[1]) annotation(
        Line(points = {{68.5, -13}, {76.5, -13}}));
      connect(dataSend.outPort, SendCRC.inPort[1]) annotation(
        Line(points = {{68.5, 67}, {76.5, 67}}));
      connect(noDataSend.outPort, SendCRC.inPort[2]) annotation(
        Line(points = {{68.5, 25}, {71, 25}, {71, 67}, {77, 67}}));
      connect(SendDLC.outPort[2], noDataSend.inPort) annotation(
        Line(points = {{17.5, 67}, {19.5, 67}, {19.5, 25}, {63.5, 25}}));
      connect(bitCount19AndnoData.y, noDataSend.condition) annotation(
        Line(points = {{18, 11}, {58, 11}, {58, 12}, {66, 12}, {66, 13}}, color = {255, 0, 255}));
      connect(bitCount19AndnoData.y, noDataReveive.condition) annotation(
        Line(points = {{18, 11}, {59, 11}, {59, -65}, {67, -65}}, color = {255, 0, 255}));
      connect(ReceiveDLC.outPort[2], noDataReveive.inPort) annotation(
        Line(points = {{17.5, -13}, {19.5, -13}, {19.5, -53}, {63.5, -53}}));
      connect(noDataReveive.outPort, ReceiveCRC.inPort[2]) annotation(
        Line(points = {{68.5, -53}, {71, -53}, {71, -13}, {77, -13}}));
      connect(bitCount19PlusDataLength.y, dataSend.condition) annotation(
        Line(points = {{58, 41}, {62, 41}, {62, 54}, {66, 54}, {66, 55}}, color = {255, 0, 255}));
      connect(SendCRC.outPort[1], crcSend.inPort) annotation(
        Line(points = {{97.5, 67}, {103.5, 67}}));
      connect(crcSend.outPort, SendCRCE.inPort[1]) annotation(
        Line(points = {{108.5, 67}, {116.5, 67}}));
      connect(SendCRCE.outPort[1], crceSend.inPort) annotation(
        Line(points = {{137.5, 67}, {143.5, 67}}));
      connect(crceSend.outPort, SendACK.inPort[1]) annotation(
        Line(points = {{148.5, 67}, {156.5, 67}}));
      connect(SendACK.outPort[1], ackSend.inPort) annotation(
        Line(points = {{177.5, 67}, {183.5, 67}}));
      connect(ackSend.outPort, SendACKE.inPort[1]) annotation(
        Line(points = {{188.5, 67}, {196.5, 67}}));
      connect(SendACKE.outPort[1], ackeSend.inPort) annotation(
        Line(points = {{217.5, 67}, {223.5, 67}}));
      connect(ackeSend.outPort, SendEOF.inPort[1]) annotation(
        Line(points = {{228.5, 67}, {236.5, 67}}));
      connect(SendEOF.outPort[1], eofSend.inPort) annotation(
        Line(points = {{257.5, 67}, {263.5, 67}}));
      connect(bitCount34PlusDataLength.y, crcSend.condition) annotation(
        Line(points = {{98, 41}, {102, 41}, {102, 55}, {106, 55}}, color = {255, 0, 255}));
      connect(bitCount19.y, dlcReceived.condition) annotation(
        Line(points = {{18, 41}, {23, 41}, {23, -25}, {27, -25}}, color = {255, 0, 255}));
      connect(bitCount19.y, dlcSend.condition) annotation(
        Line(points = {{18, 41}, {22, 41}, {22, 55}, {26, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, r0Send.condition) annotation(
        Line(points = {{-22, 41}, {-18, 41}, {-18, 55}, {-14, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, ider0Received.condition) annotation(
        Line(points = {{-22, 41}, {-17, 41}, {-17, -25}, {-13, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength.y, crceSend.condition) annotation(
        Line(points = {{138, 41}, {142, 41}, {142, 55}, {146, 55}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength.y, ackSend.condition) annotation(
        Line(points = {{178, 41}, {182, 41}, {182, 55}, {186, 55}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength.y, ackeSend.condition) annotation(
        Line(points = {{218, 41}, {222, 41}, {222, 55}, {226, 55}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength.y, eofSend.condition) annotation(
        Line(points = {{258, 41}, {262, 41}, {262, 55}, {266, 55}}, color = {255, 0, 255}));
      connect(ReceiveCRC.outPort[1], crcReceived.inPort) annotation(
        Line(points = {{97.5, -13}, {103.5, -13}}));
      connect(crcReceived.outPort, ReceiveCRCE.inPort[1]) annotation(
        Line(points = {{108.5, -13}, {116.5, -13}}));
      connect(ReceiveCRCE.outPort[1], crceReveived.inPort) annotation(
        Line(points = {{137.5, -13}, {143.5, -13}}));
      connect(crceReveived.outPort, ReceiveACK.inPort[1]) annotation(
        Line(points = {{148.5, -13}, {156.5, -13}}));
      connect(ReceiveACK.outPort[1], ackReceived.inPort) annotation(
        Line(points = {{177.5, -13}, {183.5, -13}}));
      connect(ackReceived.outPort, ReceiveACKE.inPort[1]) annotation(
        Line(points = {{188.5, -13}, {196.5, -13}}));
      connect(ReceiveACKE.outPort[1], ackeReceived.inPort) annotation(
        Line(points = {{217.5, -13}, {223.5, -13}}));
      connect(ackeReceived.outPort, ReceiveEOF.inPort[1]) annotation(
        Line(points = {{228.5, -13}, {236.5, -13}}));
      connect(ReceiveEOF.outPort[1], eofReceived.inPort) annotation(
        Line(points = {{257.5, -13}, {263.5, -13}}));
      connect(booleanExpression.y, waitSending.condition) annotation(
        Line(points = {{258, 13}, {260, 13}, {260, 15}, {266, 15}}, color = {255, 0, 255}));
      connect(ReceiveEOF.outPort[2], waitSending1.inPort) annotation(
        Line(points = {{257.5, -13}, {259.5, -13}, {259.5, -53}, {263.5, -53}}));
      connect(SendEOF.outPort[2], waitSending.inPort) annotation(
        Line(points = {{257.5, 67}, {259.5, 67}, {259.5, 27}, {263.5, 27}}));
      connect(eofSend.outPort, Idle.inPort[1]) annotation(
        Line(points = {{268.5, 67}, {280.5, 67}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
      connect(eofReceived.outPort, Idle.inPort[2]) annotation(
        Line(points = {{268.5, -13}, {280.5, -13}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
      connect(waitSending.outPort, Sync.inPort[2]) annotation(
        Line(points = {{268.5, 27}, {272.5, 27}, {272.5, 83}, {-181.5, 83}, {-181.5, 67}, {-177.5, 67}}));
      connect(waitSending1.outPort, Sync.inPort[3]) annotation(
        Line(points = {{268.5, -53}, {273, -53}, {273, 83}, {-181, 83}, {-181, 67}, {-177, 67}}));
      connect(bitCount19PlusDataLength1.y, dataReceived.condition) annotation(
        Line(points = {{57, -40}, {67, -40}, {67, -25}}, color = {255, 0, 255}));
      connect(bitCount34PlusDataLength1.y, crcReceived.condition) annotation(
        Line(points = {{97, -40}, {107, -40}, {107, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength1.y, crceReveived.condition) annotation(
        Line(points = {{137, -40}, {147, -40}, {147, -25}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength1.y, ackReceived.condition) annotation(
        Line(points = {{177, -40}, {187, -40}, {187, -25}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength1.y, ackeReceived.condition) annotation(
        Line(points = {{217, -40}, {227, -40}, {227, -25}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength1.y, eofReceived.condition) annotation(
        Line(points = {{257, -40}, {267, -40}, {267, -25}}, color = {255, 0, 255}));
      connect(booleanExpression4.y, waitSending1.condition) annotation(
        Line(points = {{257, -68}, {267, -68}, {267, -65}}, color = {255, 0, 255}));
      connect(toReceive1.y, toReveive.condition) annotation(
        Line(points = {{-106, -35}, {-94, -35}, {-94, -25}}, color = {255, 0, 255}));
      connect(SYNC_SEG.outPort[1], TQ1.inPort) annotation(
        Line(points = {{-194.5, -74}, {-184.5, -74}}));
      connect(TQ1.outPort, PROP_SEG.inPort[1]) annotation(
        Line(points = {{-179.5, -74}, {-171.5, -74}}));
      connect(PROP_SEG.outPort[1], TQ2.inPort) annotation(
        Line(points = {{-150.5, -74}, {-142.5, -74}}));
      connect(TQ3.outPort, SYNC_SEG.inPort[1]) annotation(
        Line(points = {{-97.5, -74}, {-93.5, -74}, {-93.5, -94}, {-221.5, -94}, {-221.5, -74}, {-215.5, -74}}));
      connect(booleanExpression1.y, TQ1.condition) annotation(
        Line(points = {{-190, -106}, {-182, -106}, {-182, -86}}, color = {255, 0, 255}));
      connect(booleanExpression2.y, TQ2.condition) annotation(
        Line(points = {{-150, -106}, {-140, -106}, {-140, -86}}, color = {255, 0, 255}));
      connect(booleanExpression3.y, TQ3.condition) annotation(
        Line(points = {{-108, -106}, {-100, -106}, {-100, -86}}, color = {255, 0, 255}));
      connect(TQ2.outPort, PHASE_SEG2.inPort[1]) annotation(
        Line(points = {{-137.5, -74}, {-129.5, -74}}));
      connect(PHASE_SEG2.outPort[1], TQ3.inPort) annotation(
        Line(points = {{-108.5, -74}, {-102.5, -74}}));
  connect(bitCounter.y, bitCounting) annotation(
        Line(points = {{-166, 12}, {-170, 12}, {-170, -50}, {0, -50}, {0, -82}, {310, -82}}, color = {255, 127, 0}));
      annotation(
        Diagram(coordinateSystem(extent = {{-240, 100}, {300, -120}}), graphics),
  Icon(graphics = {Rectangle(origin = {-10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 140}, {70, -140}}), Text(origin = {-10, 150}, extent = {{-70, 10}, {70, -10}}, textString = "%name"), Text(origin = {-51, 130}, extent = {{-29, 10}, {29, -10}}, textString = "sending"), Text(origin = {-51, 90}, extent = {{-29, 10}, {29, -10}}, textString = "receiving"), Text(origin = {-51, 30}, extent = {{-29, 10}, {29, -10}}, textString = "changeToReceive"), Text(origin = {-51, -10}, extent = {{-29, 10}, {29, -10}}, textString = "noData"), Text(origin = {-51, -50}, extent = {{-29, 10}, {29, -10}}, textString = "dataLength"), Text(origin = {-51, -90}, extent = {{-29, 10}, {29, -10}}, textString = "readDataLength"), Text(origin = {-51, -130}, extent = {{-29, 10}, {29, -10}}, textString = "sendWaiting"), Text(origin = {31, 50}, extent = {{-29, 10}, {29, -10}}, textString = "canCoreState"), Text(origin = {31, 10}, extent = {{-29, 10}, {29, -10}}, textString = "txPoint"), Text(origin = {31, -30}, extent = {{-29, 10}, {29, -10}}, textString = "rxPoint"), Text(origin = {31, -70}, extent = {{-29, 10}, {29, -10}}, textString = "bitCounting")}, coordinateSystem(extent = {{-100, 140}, {80, -140}})),
  Documentation(info = "<html><head></head><body><div>鐘舵€佸涓嬶細</div><ol><li>Idle</li><li>Sync</li><li>Arb</li><li>Receive</li><li>SendIDE</li><li>Sendr0</li><li>SendDLC</li><li>ReceiveDLC</li><li>SendData</li><li>ReceiveData</li><li>SendCRC</li><li>ReceiveCRC</li><li>SendCRCE</li><li>ReceiveCRCE</li><li>SendACK</li><li>ReceiveACK</li><li>SendACKE</li><li>ReceiveACKE</li><li>SendEOF</li><li>ReceiveEOF</li></ol></body></html>"));
  end CANCoreStateMech;
  
    model ReadFromBufferStateMech
    Integer readData[10](start = fill(0, 10));
    Integer i(start = 0);
    Integer dataLength(start = 0);
    Integer frameInfo(start = 8);
    output Boolean IDE(start = false);
    output Boolean RTR(start = false);
    output Integer dataLengthout(start = 0);
    output Boolean DLC[4](start = fill(false, 4));
    output Boolean ID[11](start = fill(false, 11));
    output Boolean Data[64](start = fill(false, 64));
    output Boolean ArbData[12](start = fill(false, 12));
    Boolean CRC[15](start = fill(false, 15));
    Boolean CRCE(start = false);
    Boolean ACK(start = false);
    Boolean ACKE(start = false);
    Boolean EOF[7](start = fill(false, 7));
    Boolean finishReadingFromBuffer(start = false);
    Boolean startSend1(start = false);
    Boolean finishSendingToCAN(start = false);
    Modelica.StateGraph.InitialStep Wait(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-41, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal startSendSignal annotation(
        Placement(transformation(origin = {-21, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal ReadFromBuffer(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-1, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal finishReading annotation(
        Placement(transformation(origin = {19, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal sendingFrame(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {39, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal finishSendingFrame annotation(
        Placement(transformation(origin = {59, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression startToSend(y = startSend1) annotation(
        Placement(transformation(origin = {-41, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression finishReadingFromBuffer1(y = finishReadingFromBuffer) annotation(
        Placement(transformation(origin = {-1, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression finishSending(y = finishSendingToCAN) annotation(
        Placement(transformation(origin = {39, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
        Placement(transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, 10}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}})));
    //===========================================================
      Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -90}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput finishedSend annotation(
        Placement(transformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    input Boolean wtf;
    Modelica.Blocks.Interfaces.BooleanOutput finishReadStartSend annotation(
        Placement(transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}})));
    Integer temp(start = 0);
    output Boolean DLC2[4](start = fill(false, 4));
    algorithm
    when clk then
      if ReadFromBuffer.active then
        readTag := true;
      end if;
    end when;
    when not clk then
      if ReadFromBuffer.active then
        i := i + 1;
        readData[i] := readInt;
        readTag := false;
        if i >= dataLength + 2 then
          ID := utils.intToBoolArray(b=readData[1]*8+integer(readData[2]/32), N=11);
          for x in 1:8 loop
            Data[1+8*(x-1):8*x] := utils.intToBoolArray(b=readData[x+2], N=8);
          end for;
          ArbData := cat(1, ID, {RTR});
          CRC := fill(true, 15);
          CRCE := true;
          ACK := true;
          ACKE := true;
          EOF := fill(true, 7);
          finishReadingFromBuffer := true;
        end if;
      end if;
    end when;
    when Wait.active then
      frameInfo := 0;
      IDE := false;
      RTR := false;
      dataLength := 0;
      DLC := fill(false, 4);
      DLC2 := fill(false, 4);
      ID := fill(false, 11);
      Data := fill(false, 64);
      readData := fill(0, 10);
      ArbData := fill(false, 12);
      finishSendingToCAN := false;
      finishReadStartSend := false;
    end when;
    when ReadFromBuffer.active then
        startSend1 := false;
        i := 0;
        frameInfo := TxFrameInfo;
        IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
        RTR := if frameInfo>=128 then true else false;
        dataLength := mod(frameInfo, 16);
        temp := dataLength;
        
        DLC2[1] := if temp >= integer(2^3) then true else false;
        temp := if DLC2[1] then temp-integer(2^3) else temp;
        DLC2[2] := if temp >= integer(2^2) then true else false;
        temp := if DLC2[2] then temp-integer(2^2) else temp;
        DLC2[3] := if temp >= integer(2^1) then true else false;
        temp := if DLC2[3] then temp-integer(2^1) else temp;
        DLC2[4] := if temp >= integer(2^0) then true else false;
        temp := if DLC2[4] then temp-integer(2^0) else temp;
    
        DLC := utils.intToBoolArray(b=dataLength, N=4);
      end when;
    when sendingFrame.active then
//sendingFrame
      finishReadingFromBuffer := false;
      finishReadStartSend := true;
    end when;
    when startSend then
//sendingFrame
      startSend1 := true;
    end when;
    when wtf then
//sendingFrame
      finishSendingToCAN := true;
      finishReadStartSend := false;
    end when;
    when finishedSend then
//sendingFrame
      finishSendingToCAN := true;
      finishReadStartSend := false;
    end when;
//===========================================================
    equation
      
      dataLengthout = dataLength*8;
      connect(Wait.outPort[1], startSendSignal.inPort) annotation(
        Line(points = {{-30.5, 2}, {-24.5, 2}}));
      connect(startSendSignal.outPort, ReadFromBuffer.inPort[1]) annotation(
        Line(points = {{-19.5, 2}, {-11.5, 2}}));
      connect(ReadFromBuffer.outPort[1], finishReading.inPort) annotation(
        Line(points = {{9.5, 2}, {15.5, 2}}));
      connect(finishReading.outPort, sendingFrame.inPort[1]) annotation(
        Line(points = {{20.5, 2}, {28.5, 2}}));
      connect(sendingFrame.outPort[1], finishSendingFrame.inPort) annotation(
        Line(points = {{49.5, 2}, {55.5, 2}}));
      connect(finishSendingFrame.outPort, Wait.inPort[1]) annotation(
        Line(points = {{60.5, 2}, {68.5, 2}, {68.5, 22}, {-61.5, 22}, {-61.5, 2}, {-51.5, 2}}));
      connect(startToSend.y, startSendSignal.condition) annotation(
        Line(points = {{-30, -32}, {-22, -32}, {-22, -10}}, color = {255, 0, 255}));
      connect(finishReadingFromBuffer1.y, finishReading.condition) annotation(
        Line(points = {{10, -32}, {18, -32}, {18, -10}}, color = {255, 0, 255}));
      connect(finishSending.y, finishSendingFrame.condition) annotation(
        Line(points = {{50, -32}, {58, -32}, {58, -10}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-80, 10}, {80, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startSend"), Text(origin = {-50, 40}, extent = {{-30, 10}, {30, -10}}, textString = "readInt"), Text(origin = {-50, 10}, extent = {{-30, 10}, {30, -10}}, textString = "readTag"), Text(origin = {-50, -20}, extent = {{-30, 10}, {30, -10}}, textString = "TxFrameInfo"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {-30, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishedSend"), Text(origin = {46, 50}, extent = {{-30, 10}, {30, -10}}, textString = "ID"), Text(origin = {46, 30}, extent = {{-30, 10}, {30, -10}}, textString = "IDE"), Text(origin = {46, 10}, extent = {{-30, 10}, {30, -10}}, textString = "RTR"), Text(origin = {46, -10}, extent = {{-30, 10}, {30, -10}}, textString = "DLC"), Text(origin = {46, -30}, extent = {{-30, 10}, {30, -10}}, textString = "dataLength"), Text(origin = {46, -50}, extent = {{-30, 10}, {30, -10}}, textString = "Data"), Text(origin = {46, 70}, extent = {{-30, 10}, {30, -10}}, textString = "ArbData"), Text(origin = {50, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishReadStartSend")}),
    Diagram(graphics));
    end ReadFromBufferStateMech;


    model WriteToBuffer
 Modelica.StateGraph.InitialStepWithSignal Wait(nOut = 1, nIn = 1)  annotation(
        Placement(transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}})));
 Modelica.StateGraph.TransitionWithSignal start annotation(
        Placement(transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}})));
 Modelica.StateGraph.StepWithSignal Write(nIn = 1, nOut = 1)  annotation(
        Placement(transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}})));
 Modelica.StateGraph.TransitionWithSignal finish annotation(
        Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Interfaces.BooleanInput startWrite annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Interfaces.BooleanOutput finishWrite annotation(
        Placement(transformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Interfaces.IntegerOutput writeData annotation(
        Placement(transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Interfaces.BooleanOutput writeSignal annotation(
        Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
    input Integer Data[10];
    input Integer writeDataLength;
    Integer count(start = 1);
    initial algorithm
      finishWrite := false;
      writeSignal := false;
      writeData := 0;
    algorithm
      when clk then
        if Wait.active then
          if finishWrite then
            finishWrite := false;
          end if;
        elseif Write.active then
          if count<= 10 then
            if not writeSignal then
              writeData := Data[count];
              writeSignal := true;
            else
              writeSignal := false;
              count := count + 1;
            end if;
          else
            finishWrite := true;
            count := 1;
          end if;
        end if;
      end when;
    
    
    equation
 connect(Wait.outPort[1], start.inPort) annotation(
        Line(points = {{-20, 10}, {-14, 10}}));
 connect(start.outPort, Write.inPort[1]) annotation(
        Line(points = {{-8, 10}, {0, 10}}));
 connect(Write.outPort[1], finish.inPort) annotation(
        Line(points = {{20, 10}, {26, 10}}));
 connect(finish.outPort, Wait.inPort[1]) annotation(
        Line(points = {{32, 10}, {40, 10}, {40, 30}, {-50, 30}, {-50, 10}, {-40, 10}}));
 connect(startWrite, start.condition) annotation(
        Line(points = {{-100, 70}, {-60, 70}, {-60, -20}, {-10, -20}, {-10, -2}}, color = {255, 0, 255}));
 connect(finishWrite, finish.condition) annotation(
        Line(points = {{90, 70}, {46, 70}, {46, -20}, {30, -20}, {30, -2}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startWrite"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "finishWrite"), Text(origin = {50, 30}, extent = {{-30, 10}, {30, -10}}, textString = "writeData"), Text(origin = {50, -10}, extent = {{-30, 10}, {30, -10}}, textString = "writeSignal")}),
 Diagram(graphics));
end WriteToBuffer;
  
//==========================================================================================================================================================================================================================
    parameter Real F = 1e6 "Baud rate";
    parameter Real F_osc = 16e6 "Oscillator frequency";
    parameter Integer PROP_SEG_TQ = 7 "Propagation segment time quanta";
    parameter Integer PHASE_SEG2_TQ = 8 "Phase segment 2 time quanta";
    parameter Real T_bit = 1/F;
    parameter Integer N_tq = 1 + PROP_SEG_TQ + PHASE_SEG2_TQ;
    parameter Real T_Q = T_bit/N_tq;
    parameter Integer BRP = 1;
    parameter Boolean r0 = false;
  //=================================================
    Boolean CRC[15] = fill(false, 15);
    Boolean CRCE = true;
    Boolean ACK = true;
    Boolean ACKE = true;
    Boolean EOF[7] = fill(false, 7);
    Integer dlc_received(start = 0);
    Integer readDataLength(start = 0);
    Boolean crc_received[15](start = fill(false, 15));
    Boolean IDE_received(start = false);
    Boolean RTR_received(start = false);
    Boolean DLC_received[4](start = fill(false, 4));
    Boolean Data_received[64](start = fill(false, 64));
    Boolean sending(start = false);
    Boolean receiving(start = false);
    Boolean sendWaiting(start = false);
    Boolean finishSendingToCAN(start = false);
    Boolean finishreceivingFromCAN(start = false);
    Boolean changeToReceive(start = false);
    Boolean noData(start = false);
    Boolean Record[108](start = fill(false, 108));
  //=================================================
    Modelica.Blocks.Interfaces.BooleanOutput Tx annotation(
      Placement(transformation(origin = {330, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput Rx annotation(
      Placement(transformation(origin = {330, -116}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {90, -30}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
        Placement(transformation(origin = {-40, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
        Placement(transformation(origin = {-40, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
        Placement(transformation(origin = {-30, -120}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, -50}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
        Placement(transformation(origin = {-40, -140}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
  //=================================================
    Modelica.Blocks.Sources.BooleanPulse clk(period = 1/F_osc) annotation(
        Placement(transformation(origin = {12, -202}, extent = {{-10, -10}, {10, 10}})));
    CANCoreStateMech cANCoreStateMech annotation(
        Placement(transformation(origin = {224, 1.1111}, extent = {{-43, -66.8889}, {43, 66.8889}})));
    ReadFromBufferStateMech readFromBufferStateMech annotation(
      Placement(transformation(origin = {114, -134}, extent = {{-54, -54}, {54, 54}})));
  //=================================================

    model CANCoreProcessing
      Modelica.Blocks.Interfaces.IntegerInput state annotation(
        Placement(transformation(origin = {50, 80}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {50, 122}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput Tx annotation(
        Placement(transformation(origin = {70, -10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput Rx annotation(
        Placement(transformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {70, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      Modelica.Blocks.Interfaces.BooleanInput txPoint annotation(
        Placement(transformation(origin = {70, 50}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {70, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      Modelica.Blocks.Interfaces.BooleanInput rxPoint annotation(
        Placement(transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      input Boolean DLC[4];
      input Boolean ID[11];
      input Boolean Data[64];
      input Boolean ArbData[12];
      input Boolean IDE;
      input Boolean RTR;
      input Integer dataLength;
      Modelica.Blocks.Interfaces.IntegerInput bitCount annotation(
        Placement(transformation(origin = {70, -50}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {70, -50}, extent = {{10, -10}, {-10, 10}})));
      Modelica.Blocks.Interfaces.BooleanOutput sending annotation(
        Placement(transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-50, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanOutput receiving annotation(
        Placement(transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-30, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanOutput changeToReceive annotation(
        Placement(transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-10, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanOutput sendWaiting annotation(
        Placement(transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {10, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanOutput noData annotation(
        Placement(transformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {30, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Boolean Record[200](start = fill(false, 200));
      Boolean r0 = false;
      Boolean CRC[15] = fill(false, 15);
      Boolean CRCE = true;
      Boolean ACK = true;
      Boolean ACKE = true;
      Boolean EOF[7] = fill(false, 7);
      Integer dlc_received(start = 0);
      Integer readDataLength(start = 0);
      Boolean crc_received[15](start = fill(false, 15));
      Boolean IDE_received(start = false);
      Boolean RTR_received(start = false);
      Boolean DLC_received[4](start = fill(false, 4));
      Boolean Data_received[64](start = fill(false, 64));
      Modelica.Blocks.Interfaces.BooleanOutput finishSendingToCAN annotation(
        Placement(transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanOutput finishreceivingFromCAN annotation(
        Placement(transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}})));
      output Boolean wtf(start = false);
    initial algorithm
      wtf := false;
    algorithm
      when state == 1 then
        wtf := false;
        finishSendingToCAN := false;
      end when;
      when state == 2 then
        if sending and not sendWaiting then
          sendWaiting := true;
        end if;
      end when;
//=================================================
//鐘舵€侀€昏緫
      when txPoint then
        if state == 1 then
    //绌洪棽鐘舵€?
//do nothing
elseif state == 2 then
//鍚屾鐘舵€?
          Tx := false;
    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif state == 3 then
//浠茶鍏煎彂閫佺姸鎬?
          Tx := ArbData[bitCount];
    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif state == 4 then
    //鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//do nothing
elseif state == 5 then
//鍙戦€両DE鐘舵€?
          Tx := IDE;
    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif state == 6 then
//鍙戦€乺0鐘舵€?
          Tx := r0;
    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif state == 7 then
//鍙戦€丏LC鐘舵€?
          Tx := DLC[bitCount - 14];
    //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif state == 8 then
    //鎺ユ敹DLC鐘舵€?
//do nothing
elseif state == 9 then
//鍙戦€丏ata鐘舵€?
          Tx := Data[bitCount - 18];
        elseif state == 10 then
    //鎺ユ敹Data鐘舵€?
//do nothing
elseif state == 11 then
//鍙戦€丆RC鐘舵€?
          Tx := CRC[bitCount - 18 - dataLength*8];
        elseif state == 12 then
    //鎺ユ敹CRC鐘舵€?
//do nothing
elseif state == 13 then
//鍙戦€丆RCE鐘舵€?
          Tx := CRCE;
        elseif state == 14 then
    //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif state == 15 then
//鍙戦€丄CK鐘舵€?
          Tx := true;
        elseif state == 16 then
//鎺ユ敹ACK鐘舵€?
          Tx := false;
        elseif state == 17 then
//鍙戦€丄CKE鐘舵€?
          Tx := true;
        elseif state == 18 then
    //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif state == 19 then
//鍙戦€丒OF鐘舵€?
          Tx := true;
          Modelica.Utilities.Streams.print(String(time)+ ": finishSendingToCAN = "+ String(finishSendingToCAN));
          if bitCount >= (43 + dataLength*8) then
            Modelica.Utilities.Streams.print(String(time)+ ": bitCount = "+ String(bitCount));
            sending := false;
            sendWaiting := false;
            finishSendingToCAN := true;
            Modelica.Utilities.Streams.print(String(time)+ ": finishSendingToCAN = "+ String(finishSendingToCAN));
            wtf := true;
          end if;
        elseif state == 20 then
//鎺ユ敹EOF鐘舵€?
          if bitCount >= (43 + readDataLength) then
            receiving := false;
            finishreceivingFromCAN := true;
            changeToReceive := false;
          end if;
        end if;
      end when;
//=========================================================================================================
      when rxPoint then
        if state == 1 then
    //绌洪棽鐘舵€?
//do nothing
elseif state == 2 then
    //鍚屾鐘舵€?
//do nothing
elseif state == 3 then
//浠茶鍏煎彂閫佺姸鎬?
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鑻x涓洪珮鑰孯x涓轰綆锛屽垯鐩存帴杩涘叆鎺ユ敹閫昏緫
          Record[bitCount] := Rx;
          if Tx and not Rx then
            changeToReceive := true;
            sending := false;
            receiving := true;
          end if;
        elseif state == 4 then
//鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
          Record[bitCount] := Rx;
    //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif state == 5 then
    //鍙戦€両DE鐘舵€?
//do nothing
elseif state == 6 then
    //鍙戦€乺0鐘舵€?
//do nothing
elseif state == 7 then
    //鍙戦€丏LC鐘舵€?
//do nothing
elseif state == 8 then
//鎺ユ敹DLC鐘舵€?
          Record[bitCount] := Rx;
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
          dlc_received := dlc_received*2 + utils.boolToInt(Rx);
//璁板綍DLC
          if bitCount >= 18 then
            readDataLength := dlc_received*8;
//鍥涗釜bit鍚庢洿鏂版暣甯ч暱搴?
            if dlc_received == 0 then
              noData := true;
            else
              noData := false;
            end if;
          end if;
        elseif state == 9 then
    //鍙戦€丏ata鐘舵€?
//do nothing
elseif state == 10 then
    //鎺ユ敹Data鐘舵€?
//do nothing
elseif state == 11 then
    //鍙戦€丆RC鐘舵€?
//do nothing
elseif state == 12 then
//鎺ユ敹CRC鐘舵€?
          Record[bitCount] := Rx;
          crc_received[bitCount - 18 - readDataLength] := Rx;
    //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif state == 13 then
    //鍙戦€丆RCE鐘舵€?
//do nothing
elseif state == 14 then
    //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif state == 15 then
    //鍙戦€丄CK鐘舵€?
//do nothing
elseif state == 16 then
    //鎺ユ敹ACK鐘舵€?
//do nothing
elseif state == 17 then
    //鍙戦€丄CKE鐘舵€?
//do nothing
elseif state == 18 then
    //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif state == 19 then
//鍙戦€丒OF鐘舵€?
    Modelica.Utilities.Streams.print(String(time)+ ": finishSendingToCAN = "+ String(finishSendingToCAN));
elseif state == 20 then
//鎺ユ敹EOF鐘舵€?
          if finishreceivingFromCAN then
            finishreceivingFromCAN := false;
            IDE_received := Record[12];
            RTR_received := Record[13];
            DLC_received := Record[14:17];
            if not noData then
              Data_received[1:readDataLength] := Record[18:17 + readDataLength];
            end if;
            noData := false;
          end if;
        end if;
      end when;
    equation
    
      annotation(
        Diagram(graphics = {Rectangle(origin = {0, -20}, extent = {{-60, 80}, {60, -80}})}, coordinateSystem(extent = {{-100, 100}, {80, -100}})),
        Icon(graphics = {Rectangle(origin = {0, -23}, extent = {{-60, 135}, {60, -135}}), Text(origin = {0, -147}, extent = {{-60, 11}, {60, -11}}, textString = "%name"), Text(origin = {50, 92}, rotation = 90, extent = {{-20, 10}, {20, -10}}, textString = "state"), Text(origin = {-34, 50}, extent = {{-20, 10}, {20, -10}}, textString = "ID11"), Text(origin = {-34, 30}, extent = {{-20, 10}, {20, -10}}, textString = "IDE"), Text(origin = {-34, 10}, extent = {{-20, 10}, {20, -10}}, textString = "RTR"), Text(origin = {-34, -10}, extent = {{-20, 10}, {20, -10}}, textString = "DLC4"), Text(origin = {-34, -30}, extent = {{-20, 10}, {20, -10}}, textString = "dataLength"), Text(origin = {-34, -50}, extent = {{-20, 10}, {20, -10}}, textString = "Data"), Text(origin = {40, 50}, extent = {{-20, 10}, {20, -10}}, textString = "txPoint"), Text(origin = {40, 30}, extent = {{-20, 10}, {20, -10}}, textString = "rxPoint"), Text(origin = {40, 0}, extent = {{-20, 10}, {20, -10}}, textString = "Tx"), Text(origin = {40, -30}, extent = {{-20, 10}, {20, -10}}, textString = "Rx"), Text(origin = {40, -50}, extent = {{-20, 10}, {20, -10}}, textString = "bitCount"), Text(origin = {30, 92}, rotation = 90, extent = {{-20, 10}, {20, -10}}, textString = "noData"), Text(origin = {10, 92}, rotation = 90, extent = {{-20, 10}, {20, -10}}, textString = "sendWaiting"), Text(origin = {-10, 92}, rotation = 90, extent = {{-20, 10}, {20, -10}}, textString = "changeToReceive"), Text(origin = {-30, 92}, rotation = 90, extent = {{-20, 10}, {20, -10}}, textString = "receiving"), Text(origin = {-50, 92}, rotation = 90, extent = {{-20, 10}, {20, -10}}, textString = "sending"), Text(origin = {-38, 68}, extent = {{-20, 6}, {20, -6}}, textString = "ArbData"), Text(origin = {20, -70}, extent = {{-40, 10}, {40, -10}}, textString = "finishSendingToCAN"), Text(origin = {20, -90}, extent = {{-40, 10}, {40, -10}}, textString = "finishreceivingFromCAN")}, coordinateSystem(extent = {{-80, 140}, {80, -160}})),
        Documentation(info = "<html><head></head><body><div><br></div><div><ol><li><span style=\"font-family: 瀹嬩綋; font-size: 12px;\">Idle</span></li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Sync</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Arb</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Receive</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendIDE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Sendr0</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendDLC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveDLC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendData</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveData</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendCRC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveCRC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendCRCE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveCRCE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendACK</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveACK</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendACKE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveACKE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendEOF</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveEOF</li></ol></div></body></html>"));
    end CANCoreProcessing;
  algorithm  //杩愯閫昏緫閮ㄥ垎
    when readFromBufferStateMech.finishReadStartSend then
      
      cANCoreStateMech.dataLength := readFromBufferStateMech.dataLength;
      cANCoreStateMech.readDataLength := 0;//todo
    end when;
//=================================================
//鐘舵€侀€昏緫
    when cANCoreStateMech.txPoint then
      if cANCoreStateMech.canCoreState == 1 then
  //绌洪棽鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 2 then
//鍚屾鐘舵€?
        Tx := false;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 3 then
//浠茶鍏煎彂閫佺姸鎬?
        Tx := readFromBufferStateMech.ArbData[cANCoreStateMech.bitCounting];
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 4 then
  //鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 5 then
//鍙戦€両DE鐘舵€?
        Tx := readFromBufferStateMech.IDE;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 6 then
//鍙戦€乺0鐘舵€?
        Tx := r0;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 7 then
//鍙戦€丏LC鐘舵€?
        Tx := readFromBufferStateMech.DLC[cANCoreStateMech.bitCounting - 14];
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 8 then
  //鎺ユ敹DLC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 9 then
//鍙戦€丏ata鐘舵€?
        Tx := readFromBufferStateMech.Data[cANCoreStateMech.bitCounting - 18];
      elseif cANCoreStateMech.canCoreState == 10 then
  //鎺ユ敹Data鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 11 then
//鍙戦€丆RC鐘舵€?
        Tx := CRC[cANCoreStateMech.bitCounting - 18 - readFromBufferStateMech.dataLength*8];
      elseif cANCoreStateMech.canCoreState == 12 then
  //鎺ユ敹CRC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 13 then
//鍙戦€丆RCE鐘舵€?
        Tx := CRCE;
      elseif cANCoreStateMech.canCoreState == 14 then
  //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 15 then
//鍙戦€丄CK鐘舵€?
        Tx := true;
      elseif cANCoreStateMech.canCoreState == 16 then
//鎺ユ敹ACK鐘舵€?
        Tx := false;
      elseif cANCoreStateMech.canCoreState == 17 then
//鍙戦€丄CKE鐘舵€?
        Tx := true;
      elseif cANCoreStateMech.canCoreState == 18 then
  //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 19 then
//鍙戦€丒OF鐘舵€?
        Tx := true;
        if cANCoreStateMech.bitCounting >= (43 + readFromBufferStateMech.dataLength*8) then
          sending := false;
          sendWaiting := false;
          finishSendingToCAN := true;
          
        end if;
      elseif cANCoreStateMech.canCoreState == 20 then
//鎺ユ敹EOF鐘舵€?
        if cANCoreStateMech.bitCounting >= (43 + readDataLength) then
          receiving := false;
          finishreceivingFromCAN := true;
          changeToReceive := false;
        end if;
      end if;
    end when;
//=========================================================================================================
    when cANCoreStateMech.rxPoint then
      if cANCoreStateMech.canCoreState == 1 then
  //绌洪棽鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 2 then
  //鍚屾鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 3 then
//浠茶鍏煎彂閫佺姸鎬?
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鑻x涓洪珮鑰孯x涓轰綆锛屽垯鐩存帴杩涘叆鎺ユ敹閫昏緫
        Record[cANCoreStateMech.bitCounting] := Rx;
        if Tx and not Rx then
          changeToReceive := true;
          sending := false;
          receiving := true;
        end if;
      elseif cANCoreStateMech.canCoreState == 4 then
//鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
  //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif cANCoreStateMech.canCoreState == 5 then
  //鍙戦€両DE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 6 then
  //鍙戦€乺0鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 7 then
  //鍙戦€丏LC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 8 then
//鎺ユ敹DLC鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
        dlc_received := dlc_received*2 + utils.boolToInt(Rx);
//璁板綍DLC
        if cANCoreStateMech.bitCounting >= 18 then
          readDataLength := dlc_received*8;
//鍥涗釜bit鍚庢洿鏂版暣甯ч暱搴?
          if dlc_received == 0 then
            noData := true;
          else
            noData := false;
          end if;
        end if;
      elseif cANCoreStateMech.canCoreState == 9 then
  //鍙戦€丏ata鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 10 then
  //鎺ユ敹Data鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 11 then
  //鍙戦€丆RC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 12 then
//鎺ユ敹CRC鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
        crc_received[cANCoreStateMech.bitCounting - 18 - readDataLength] := Rx;
  //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif cANCoreStateMech.canCoreState == 13 then
  //鍙戦€丆RCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 14 then
  //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 15 then
  //鍙戦€丄CK鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 16 then
  //鎺ユ敹ACK鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 17 then
  //鍙戦€丄CKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 18 then
  //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 19 then
  //鍙戦€丒OF鐘舵€?
elseif cANCoreStateMech.canCoreState == 20 then
//鎺ユ敹EOF鐘舵€?
        if finishreceivingFromCAN then
          finishreceivingFromCAN := false;
          IDE_received := Record[12];
          RTR_received := Record[13];
          DLC_received := Record[14:17];
          if not noData then
            Data_received[1:readDataLength] := Record[18:17 + readDataLength];
          end if;
          noData := false;
        end if;
      end if;
    end when;
  equation
    connect(clk.y, readFromBufferStateMech.clk) annotation(
      Line(points = {{24, -202}, {40, -202}, {40, -161}, {65, -161}}, color = {255, 0, 255}));
    connect(TxFrameInfo, readFromBufferStateMech.TxFrameInfo) annotation(
      Line(points = {{-40, -80}, {40, -80}, {40, -145}, {65, -145}}, color = {255, 127, 0}));
    connect(readFromBufferStateMech.readTag, readTag) annotation(
      Line(points = {{65, -129}, {20, -129}, {20, -120}, {-30, -120}}, color = {255, 0, 255}));
    connect(readInt, readFromBufferStateMech.readInt) annotation(
      Line(points = {{-40, -140}, {32, -140}, {32, -112}, {65, -112}}, color = {255, 127, 0}));
    connect(startSend, readFromBufferStateMech.startSend) annotation(
      Line(points = {{-40, 40}, {24, 40}, {24, -96}, {65, -96}}, color = {255, 0, 255}));
    annotation(
      Icon(graphics = {Rectangle(fillColor = {85, 85, 0}, fillPattern = FillPattern.Horizontal, extent = {{-80, 80}, {80, -80}}), Text(origin = {70, 30}, extent = {{-10, 10}, {10, -10}}, textString = "Tx"), Text(origin = {70, -30}, extent = {{-10, 10}, {10, -10}}, textString = "Rx"), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-40, 71}, extent = {{-40, 9}, {40, -9}}, textString = "startSend"), Text(origin = {-40, 51}, extent = {{-40, 9}, {40, -9}}, textString = "TxFrameInfo"), Text(origin = {-40, -49}, extent = {{-40, 9}, {40, -9}}, textString = "readTag"), Text(origin = {-40, -69}, extent = {{-40, 9}, {40, -9}}, textString = "readInt")}),
      Diagram(graphics = {Rectangle(origin = {150, -90}, extent = {{-170, 190}, {170, -190}})}, coordinateSystem(extent = {{-60, 100}, {340, -280}})),
  Documentation(info = "<html><head></head><body><div><div><br></div></div><div><ol><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Idle</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Sync</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Arb</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Receive</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendIDE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Sendr0</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendDLC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveDLC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendData</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveData</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendCRC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveCRC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendCRCE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveCRCE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendACK</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveACK</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendACKE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveACKE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendEOF</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveEOF</li></ol></div></body></html>"));
  end CANCore2;

  model CANCore3
    
    
    model RxSampler
      extends Modelica.Blocks.Icons.DiscreteBlock;
      parameter Boolean y_start = true "Initial value of output signal";
      Modelica.Blocks.Interfaces.BooleanInput u "Connector with a Boolean input signal" annotation(
        Placement(transformation(origin = {0, 60}, extent = {{-140, -20}, {-100, 20}}), iconTransformation(origin = {0, 64}, extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y "Connector with a Boolean output signal" annotation(
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger input" annotation(
        Placement(transformation(origin = {0, -118}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanInput v annotation(
        Placement(transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}})));
    equation
      when trigger then
        y = (u and not v) or (v and not u);
      end when;
    initial equation
      y = y_start;
    end RxSampler;
  
    model TQCounter
      parameter Integer N_tq = 16;
      Modelica.Blocks.Interfaces.BooleanInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      when y >= N_tq then
        y := 0;
      end when;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%N_tq")}));
    end TQCounter;
  
    model TQTimer
      parameter Real TQ = 1;
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Real x(start = 0);
    equation
      der(x) = 1;
      when reset then
        reinit(x, 0);
      end when;
      when x >= TQ then
        reinit(x, 0);
      end when;
      y = x < TQ/2;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%TQ")}));
    end TQTimer;
  
    model BitCounter
      Modelica.Blocks.Interfaces.IntegerInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count == 0 then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})),
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name")}));
    end BitCounter;
  
    
  
    model CANCoreStateMech
    //========================================================================
    parameter Real T_Q = 1;
    parameter Integer N_tq = 16;
    parameter Integer PROP_SEG_TQ = 7;
    //========================================================================
  Modelica.StateGraph.InitialStep Idle(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-213, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal whenRxLow annotation(
        Placement(transformation(origin = {-187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenRxFalse(y =  sending or receiving) annotation(
        Placement(transformation(origin = {-211, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sync(nIn = 3, nOut = 2) annotation(
        Placement(transformation(origin = {-167, 67}, extent = {{-10, -10}, {10, 10}})));
  BitCounter bitCounter annotation(
        Placement(transformation(origin = {-173, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal bit1 annotation(
        Placement(transformation(origin = {-139, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenbit1(y = (tQCounter.y >= N_tq - 1) and sending) annotation(
        Placement(transformation(origin = {-153, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Arb(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {-117, 67}, extent = {{-10, -10}, {10, 10}})));
  TQCounter tQCounter(N_tq = N_tq) annotation(
        Placement(transformation(origin = {-191, 11}, extent = {{-10, -10}, {10, 10}})));
  TQTimer tQTimer(TQ = T_Q) annotation(
        Placement(transformation(origin = {-211, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Receive(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-73, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal toReveive annotation(
        Placement(transformation(origin = {-93, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startReceiving annotation(
        Placement(transformation(origin = {-139, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenBit1AndNotSending(y = (tQCounter.y >= N_tq - 1) and not sending) annotation(
        Placement(transformation(origin = {-153, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal arbSuccess annotation(
        Placement(transformation(origin = {-93, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount13(y = (bitCounter.y >= 13) and sending) annotation(
        Placement(transformation(origin = {-117, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendIDE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-73, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ideSend annotation(
        Placement(transformation(origin = {-53, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount14(y = bitCounter.y >= 14) annotation(
        Placement(transformation(origin = {-73, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sendr0(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-33, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount15(y = bitCounter.y >= 15) annotation(
        Placement(transformation(origin = {-33, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal r0Send annotation(
        Placement(transformation(origin = {-13, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcSend annotation(
        Placement(transformation(origin = {27, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19(y = (bitCounter.y >= 19) and not noDataToSend) annotation(
        Placement(transformation(origin = {7, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ider0Received annotation(
        Placement(transformation(origin = {-13, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcReceived annotation(
        Placement(transformation(origin = {27, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataSend annotation(
        Placement(transformation(origin = {67, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataReceived annotation(
        Placement(transformation(origin = {67, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataSend annotation(
        Placement(transformation(origin = {67, 25}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndnoData(y = (bitCounter.y >= 19) and noDataToSend) annotation(
        Placement(transformation(origin = {7, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataReveive annotation(
        Placement(transformation(origin = {67, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcSend annotation(
        Placement(transformation(origin = {107, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceSend annotation(
        Placement(transformation(origin = {147, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackSend annotation(
        Placement(transformation(origin = {187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeSend annotation(
        Placement(transformation(origin = {227, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendEOF(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {247, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofSend annotation(
        Placement(transformation(origin = {267, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength(y = bitCounter.y >= (19 + dataLength*8)) annotation(
        Placement(transformation(origin = {47, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength(y = bitCounter.y >= (34 + dataLength*8)) annotation(
        Placement(transformation(origin = {87, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength(y = bitCounter.y >= (35 + dataLength*8)) annotation(
        Placement(transformation(origin = {127, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength(y = bitCounter.y >= (36 + dataLength*8)) annotation(
        Placement(transformation(origin = {167, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength(y = bitCounter.y >= (37 + dataLength*8)) annotation(
        Placement(transformation(origin = {207, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength(y = (bitCounter.y >= (44 + dataLength*8)) and not sendWaiting) annotation(
        Placement(transformation(origin = {247, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcReceived annotation(
        Placement(transformation(origin = {107, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step ReceiveCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceReveived annotation(
        Placement(transformation(origin = {147, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackReceived annotation(
        Placement(transformation(origin = {187, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeReceived annotation(
        Placement(transformation(origin = {227, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveEOF(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {247, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofReceived annotation(
        Placement(transformation(origin = {267, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = (bitCounter.y >= (44 + dataLength*8)) and sendWaiting) annotation(
        Placement(transformation(origin = {247, 13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending annotation(
        Placement(transformation(origin = {267, 27}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending1 annotation(
        Placement(transformation(origin = {267, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression toReceive1(y = changeToReceive) annotation(
        Placement(transformation(origin = {-117, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength1(y = bitCounter.y >= (19 + readDataLength)) annotation(
        Placement(transformation(origin = {46, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength1(y = bitCounter.y >= (34 + readDataLength)) annotation(
        Placement(transformation(origin = {86, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength1(y = bitCounter.y >= (35 + readDataLength)) annotation(
        Placement(transformation(origin = {126, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength1(y = bitCounter.y >= (36 + readDataLength)) annotation(
        Placement(transformation(origin = {166, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength1(y = bitCounter.y >= (37 + readDataLength)) annotation(
        Placement(transformation(origin = {206, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength1(y = (bitCounter.y >= (44 + readDataLength)) and not sendWaiting) annotation(
        Placement(transformation(origin = {246, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = (bitCounter.y >= (44 + readDataLength)) and sendWaiting) annotation(
        Placement(transformation(origin = {246, -68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep SYNC_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-205, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ1 annotation(
        Placement(transformation(origin = {-181, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step PROP_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-161, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ2 annotation(
        Placement(transformation(origin = {-139, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ3 annotation(
        Placement(transformation(origin = {-99, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = tQCounter.y >= 1) annotation(
        Placement(transformation(origin = {-201, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = tQCounter.y >= PROP_SEG_TQ + 1) annotation(
        Placement(transformation(origin = {-161, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = tQCounter.y == 0) annotation(
        Placement(transformation(origin = {-119, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal PHASE_SEG2(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-119, -74}, extent = {{-10, -10}, {10, 10}})));
  //======================================================================================
      //======================================================================================
    input Integer dataLength;
    input Integer readDataLength;
    input Boolean sending;
    input Boolean receiving;
    input Boolean changeToReceive;
    input Boolean noDataToSend;
    input Boolean sendWaiting;
    output Boolean noDataToReceive;
    output Integer canCoreState(start = 1);
    output Boolean txPoint(start = false);
    output Boolean rxPoint(start = false);
    output Integer bitCounting(start = 0);
  //======================================================================================
      Modelica.Blocks.Sources.BooleanExpression bitCount19AndNoDataToR(y = (bitCounter.y >= 19) and noDataToReceive)  annotation(
        Placement(transformation(origin = {6, -72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y = (bitCounter.y >= 19) and not noDataToReceive)  annotation(
        Placement(transformation(origin = {6, -38}, extent = {{-10, -10}, {10, 10}})));
    initial algorithm
      canCoreState := 1;
    algorithm
      when Idle.active then
        canCoreState := 1;
      end when;
      when Sync.active then
        canCoreState := 2;
      end when;
      when Arb.active then
        canCoreState := 3;
      end when;
      when Receive.active then
        canCoreState := 4;
      end when;
      when SendIDE.active then
        canCoreState := 5;
      end when;
      when Sendr0.active then
        canCoreState := 6;
      end when;
      when SendDLC.active then
        canCoreState := 7;
      end when;
      when ReceiveDLC.active then
        canCoreState := 8;
      end when;
      when SendData.active then
        canCoreState := 9;
      end when;
      when ReceiveData.active then
        canCoreState := 10;
      end when;
      when SendCRC.active then
        canCoreState := 11;
      end when;
      when ReceiveCRC.active then
        canCoreState := 12;
      end when;
      when SendCRCE.active then
        canCoreState := 13;
      end when;
      when ReceiveCRCE.active then
        canCoreState := 14;
      end when;
      when SendACK.active then
        canCoreState := 15;
      end when;
      when ReceiveACK.active then
        canCoreState := 16;
      end when;
      when SendACKE.active then
        canCoreState := 17;
      end when;
      when ReceiveACKE.active then
        canCoreState := 18;
      end when;
      when SendEOF.active then
        canCoreState := 19;
      end when;
      when ReceiveEOF.active then
        canCoreState := 20;
      end when;
      
    equation
      txPoint = (tQCounter.y == 1);
      rxPoint = (tQCounter.y == PROP_SEG_TQ + 1);
      bitCounter.y = bitCounting; 
      connect(whenRxFalse.y, whenRxLow.condition) annotation(
        Line(points = {{-200, 41}, {-188, 41}, {-188, 55}}, color = {255, 0, 255}));
      connect(Idle.outPort[1], whenRxLow.inPort) annotation(
        Line(points = {{-202.5, 67}, {-190.5, 67}}));
      connect(whenRxLow.outPort, Sync.inPort[1]) annotation(
        Line(points = {{-185.5, 67}, {-177.5, 67}}));
      connect(Sync.active, tQCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-191, 23}, {-191, 18}}, color = {255, 0, 255}));
      connect(Sync.active, tQTimer.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-211, 23}, {-211, 18}}, color = {255, 0, 255}));
      connect(tQTimer.y, tQCounter.count) annotation(
        Line(points = {{-204, 11}, {-198, 11}}, color = {255, 0, 255}));
      connect(Sync.outPort[1], bit1.inPort) annotation(
        Line(points = {{-156.5, 67}, {-143, 67}}));
      connect(whenbit1.y, bit1.condition) annotation(
        Line(points = {{-142, 41}, {-140, 41}, {-140, 55}}, color = {255, 0, 255}));
      connect(bit1.outPort, Arb.inPort[1]) annotation(
        Line(points = {{-137.5, 67}, {-127.5, 67}}));
      connect(tQCounter.y, bitCounter.count) annotation(
        Line(points = {{-184, 11}, {-180, 11}}, color = {255, 127, 0}));
      connect(Arb.outPort[1], toReveive.inPort) annotation(
        Line(points = {{-106.5, 67}, {-102.5, 67}, {-102.5, -13}, {-97, -13}}));
      connect(toReveive.outPort, Receive.inPort[1]) annotation(
        Line(points = {{-91.5, -13}, {-83.5, -13}}));
      connect(Sync.active, bitCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 22}, {-173, 22}, {-173, 18}}, color = {255, 0, 255}));
      connect(Sync.outPort[2], startReceiving.inPort) annotation(
        Line(points = {{-156.5, 67}, {-150.5, 67}, {-150.5, -13}, {-143, -13}}));
      connect(startReceiving.outPort, Receive.inPort[2]) annotation(
        Line(points = {{-137.5, -13}, {-107.5, -13}, {-107.5, -1}, {-87.5, -1}, {-87.5, -13}, {-83.5, -13}}));
      connect(whenBit1AndNotSending.y, startReceiving.condition) annotation(
        Line(points = {{-142, -35}, {-139, -35}, {-139, -25}}, color = {255, 0, 255}));
      connect(Arb.outPort[2], arbSuccess.inPort) annotation(
        Line(points = {{-106.5, 67}, {-96.5, 67}}));
      connect(bitCount13.y, arbSuccess.condition) annotation(
        Line(points = {{-106, 41}, {-94, 41}, {-94, 55}}, color = {255, 0, 255}));
      connect(arbSuccess.outPort, SendIDE.inPort[1]) annotation(
        Line(points = {{-91.5, 67}, {-83.5, 67}}));
      connect(bitCount14.y, ideSend.condition) annotation(
        Line(points = {{-62, 41}, {-54, 41}, {-54, 55}}, color = {255, 0, 255}));
      connect(SendIDE.outPort[1], ideSend.inPort) annotation(
        Line(points = {{-62.5, 67}, {-56.5, 67}}));
      connect(ideSend.outPort, Sendr0.inPort[1]) annotation(
        Line(points = {{-51.5, 67}, {-43.5, 67}}));
      connect(Sendr0.outPort[1], r0Send.inPort) annotation(
        Line(points = {{-22.5, 67}, {-16.5, 67}}));
      connect(SendDLC.outPort[1], dlcSend.inPort) annotation(
        Line(points = {{17.5, 67}, {23.5, 67}}));
      connect(r0Send.outPort, SendDLC.inPort[1]) annotation(
        Line(points = {{-11.5, 67}, {-3.5, 67}}));
      connect(ider0Received.outPort, ReceiveDLC.inPort[1]) annotation(
        Line(points = {{-11.5, -13}, {-3.5, -13}}));
      connect(Receive.outPort[1], ider0Received.inPort) annotation(
        Line(points = {{-62.5, -13}, {-16.5, -13}}));
      connect(ReceiveDLC.outPort[1], dlcReceived.inPort) annotation(
        Line(points = {{17.5, -13}, {23.5, -13}}));
      connect(dlcSend.outPort, SendData.inPort[1]) annotation(
        Line(points = {{28.5, 67}, {36.5, 67}}));
      connect(dlcReceived.outPort, ReceiveData.inPort[1]) annotation(
        Line(points = {{28.5, -13}, {36.5, -13}}));
      connect(SendData.outPort[1], dataSend.inPort) annotation(
        Line(points = {{57.5, 67}, {63.5, 67}}));
      connect(ReceiveData.outPort[1], dataReceived.inPort) annotation(
        Line(points = {{57.5, -13}, {63.5, -13}}));
      connect(dataReceived.outPort, ReceiveCRC.inPort[1]) annotation(
        Line(points = {{68.5, -13}, {76.5, -13}}));
      connect(dataSend.outPort, SendCRC.inPort[1]) annotation(
        Line(points = {{68.5, 67}, {76.5, 67}}));
      connect(noDataSend.outPort, SendCRC.inPort[2]) annotation(
        Line(points = {{68.5, 25}, {71, 25}, {71, 67}, {77, 67}}));
      connect(SendDLC.outPort[2], noDataSend.inPort) annotation(
        Line(points = {{17.5, 67}, {19.5, 67}, {19.5, 25}, {63.5, 25}}));
      connect(bitCount19AndnoData.y, noDataSend.condition) annotation(
        Line(points = {{18, 11}, {58, 11}, {58, 12}, {66, 12}, {66, 13}}, color = {255, 0, 255}));
      connect(ReceiveDLC.outPort[2], noDataReveive.inPort) annotation(
        Line(points = {{17.5, -13}, {19.5, -13}, {19.5, -53}, {63.5, -53}}));
      connect(noDataReveive.outPort, ReceiveCRC.inPort[2]) annotation(
        Line(points = {{68.5, -53}, {71, -53}, {71, -13}, {77, -13}}));
      connect(bitCount19PlusDataLength.y, dataSend.condition) annotation(
        Line(points = {{58, 41}, {62, 41}, {62, 54}, {66, 54}, {66, 55}}, color = {255, 0, 255}));
      connect(SendCRC.outPort[1], crcSend.inPort) annotation(
        Line(points = {{97.5, 67}, {103.5, 67}}));
      connect(crcSend.outPort, SendCRCE.inPort[1]) annotation(
        Line(points = {{108.5, 67}, {116.5, 67}}));
      connect(SendCRCE.outPort[1], crceSend.inPort) annotation(
        Line(points = {{137.5, 67}, {143.5, 67}}));
      connect(crceSend.outPort, SendACK.inPort[1]) annotation(
        Line(points = {{148.5, 67}, {156.5, 67}}));
      connect(SendACK.outPort[1], ackSend.inPort) annotation(
        Line(points = {{177.5, 67}, {183.5, 67}}));
      connect(ackSend.outPort, SendACKE.inPort[1]) annotation(
        Line(points = {{188.5, 67}, {196.5, 67}}));
      connect(SendACKE.outPort[1], ackeSend.inPort) annotation(
        Line(points = {{217.5, 67}, {223.5, 67}}));
      connect(ackeSend.outPort, SendEOF.inPort[1]) annotation(
        Line(points = {{228.5, 67}, {236.5, 67}}));
      connect(SendEOF.outPort[1], eofSend.inPort) annotation(
        Line(points = {{257.5, 67}, {263.5, 67}}));
      connect(bitCount34PlusDataLength.y, crcSend.condition) annotation(
        Line(points = {{98, 41}, {102, 41}, {102, 55}, {106, 55}}, color = {255, 0, 255}));
      connect(bitCount19.y, dlcSend.condition) annotation(
        Line(points = {{18, 41}, {22, 41}, {22, 55}, {26, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, r0Send.condition) annotation(
        Line(points = {{-22, 41}, {-18, 41}, {-18, 55}, {-14, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, ider0Received.condition) annotation(
        Line(points = {{-22, 41}, {-17, 41}, {-17, -25}, {-13, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength.y, crceSend.condition) annotation(
        Line(points = {{138, 41}, {142, 41}, {142, 55}, {146, 55}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength.y, ackSend.condition) annotation(
        Line(points = {{178, 41}, {182, 41}, {182, 55}, {186, 55}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength.y, ackeSend.condition) annotation(
        Line(points = {{218, 41}, {222, 41}, {222, 55}, {226, 55}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength.y, eofSend.condition) annotation(
        Line(points = {{258, 41}, {262, 41}, {262, 55}, {266, 55}}, color = {255, 0, 255}));
      connect(ReceiveCRC.outPort[1], crcReceived.inPort) annotation(
        Line(points = {{97.5, -13}, {103.5, -13}}));
      connect(crcReceived.outPort, ReceiveCRCE.inPort[1]) annotation(
        Line(points = {{108.5, -13}, {116.5, -13}}));
      connect(ReceiveCRCE.outPort[1], crceReveived.inPort) annotation(
        Line(points = {{137.5, -13}, {143.5, -13}}));
      connect(crceReveived.outPort, ReceiveACK.inPort[1]) annotation(
        Line(points = {{148.5, -13}, {156.5, -13}}));
      connect(ReceiveACK.outPort[1], ackReceived.inPort) annotation(
        Line(points = {{177.5, -13}, {183.5, -13}}));
      connect(ackReceived.outPort, ReceiveACKE.inPort[1]) annotation(
        Line(points = {{188.5, -13}, {196.5, -13}}));
      connect(ReceiveACKE.outPort[1], ackeReceived.inPort) annotation(
        Line(points = {{217.5, -13}, {223.5, -13}}));
      connect(ackeReceived.outPort, ReceiveEOF.inPort[1]) annotation(
        Line(points = {{228.5, -13}, {236.5, -13}}));
      connect(ReceiveEOF.outPort[1], eofReceived.inPort) annotation(
        Line(points = {{257.5, -13}, {263.5, -13}}));
      connect(booleanExpression.y, waitSending.condition) annotation(
        Line(points = {{258, 13}, {260, 13}, {260, 15}, {266, 15}}, color = {255, 0, 255}));
      connect(ReceiveEOF.outPort[2], waitSending1.inPort) annotation(
        Line(points = {{257.5, -13}, {259.5, -13}, {259.5, -53}, {263.5, -53}}));
      connect(SendEOF.outPort[2], waitSending.inPort) annotation(
        Line(points = {{257.5, 67}, {259.5, 67}, {259.5, 27}, {263.5, 27}}));
      connect(eofSend.outPort, Idle.inPort[1]) annotation(
        Line(points = {{268.5, 67}, {280.5, 67}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
      connect(eofReceived.outPort, Idle.inPort[2]) annotation(
        Line(points = {{268.5, -13}, {280.5, -13}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
      connect(waitSending.outPort, Sync.inPort[2]) annotation(
        Line(points = {{268.5, 27}, {272.5, 27}, {272.5, 83}, {-181.5, 83}, {-181.5, 67}, {-177.5, 67}}));
      connect(waitSending1.outPort, Sync.inPort[3]) annotation(
        Line(points = {{268.5, -53}, {273, -53}, {273, 83}, {-181, 83}, {-181, 67}, {-177, 67}}));
      connect(bitCount19PlusDataLength1.y, dataReceived.condition) annotation(
        Line(points = {{57, -40}, {67, -40}, {67, -25}}, color = {255, 0, 255}));
      connect(bitCount34PlusDataLength1.y, crcReceived.condition) annotation(
        Line(points = {{97, -40}, {107, -40}, {107, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength1.y, crceReveived.condition) annotation(
        Line(points = {{137, -40}, {147, -40}, {147, -25}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength1.y, ackReceived.condition) annotation(
        Line(points = {{177, -40}, {187, -40}, {187, -25}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength1.y, ackeReceived.condition) annotation(
        Line(points = {{217, -40}, {227, -40}, {227, -25}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength1.y, eofReceived.condition) annotation(
        Line(points = {{257, -40}, {267, -40}, {267, -25}}, color = {255, 0, 255}));
      connect(booleanExpression4.y, waitSending1.condition) annotation(
        Line(points = {{257, -68}, {267, -68}, {267, -65}}, color = {255, 0, 255}));
      connect(toReceive1.y, toReveive.condition) annotation(
        Line(points = {{-106, -35}, {-94, -35}, {-94, -25}}, color = {255, 0, 255}));
      connect(SYNC_SEG.outPort[1], TQ1.inPort) annotation(
        Line(points = {{-194.5, -74}, {-184.5, -74}}));
      connect(TQ1.outPort, PROP_SEG.inPort[1]) annotation(
        Line(points = {{-179.5, -74}, {-171.5, -74}}));
      connect(PROP_SEG.outPort[1], TQ2.inPort) annotation(
        Line(points = {{-150.5, -74}, {-142.5, -74}}));
      connect(TQ3.outPort, SYNC_SEG.inPort[1]) annotation(
        Line(points = {{-97.5, -74}, {-93.5, -74}, {-93.5, -94}, {-221.5, -94}, {-221.5, -74}, {-215.5, -74}}));
      connect(booleanExpression1.y, TQ1.condition) annotation(
        Line(points = {{-190, -106}, {-182, -106}, {-182, -86}}, color = {255, 0, 255}));
      connect(booleanExpression2.y, TQ2.condition) annotation(
        Line(points = {{-150, -106}, {-140, -106}, {-140, -86}}, color = {255, 0, 255}));
      connect(booleanExpression3.y, TQ3.condition) annotation(
        Line(points = {{-108, -106}, {-100, -106}, {-100, -86}}, color = {255, 0, 255}));
      connect(TQ2.outPort, PHASE_SEG2.inPort[1]) annotation(
        Line(points = {{-137.5, -74}, {-129.5, -74}}));
      connect(PHASE_SEG2.outPort[1], TQ3.inPort) annotation(
        Line(points = {{-108.5, -74}, {-102.5, -74}}));
  connect(bitCount19AndNoDataToR.y, noDataReveive.condition) annotation(
        Line(points = {{17, -72}, {65, -72}, {65, -64}, {68, -64}}, color = {255, 0, 255}));
  connect(booleanExpression5.y, dlcReceived.condition) annotation(
        Line(points = {{18, -38}, {28, -38}, {28, -24}}, color = {255, 0, 255}));
    annotation(
        Diagram(coordinateSystem(extent = {{-240, 100}, {300, -120}}), graphics),
  Icon(graphics = {Rectangle(origin = {-10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 140}, {70, -140}}), Text(origin = {-10, 150}, extent = {{-70, 10}, {70, -10}}, textString = "%name"), Text(origin = {-51, 130}, extent = {{-29, 10}, {29, -10}}, textString = "sending"), Text(origin = {-51, 90}, extent = {{-29, 10}, {29, -10}}, textString = "receiving"), Text(origin = {-51, 30}, extent = {{-29, 10}, {29, -10}}, textString = "changeToReceive"), Text(origin = {-51, -10}, extent = {{-29, 10}, {29, -10}}, textString = "noData"), Text(origin = {-51, -50}, extent = {{-29, 10}, {29, -10}}, textString = "dataLength"), Text(origin = {-51, -90}, extent = {{-29, 10}, {29, -10}}, textString = "readDataLength"), Text(origin = {-51, -130}, extent = {{-29, 10}, {29, -10}}, textString = "sendWaiting"), Text(origin = {31, 50}, extent = {{-29, 10}, {29, -10}}, textString = "canCoreState"), Text(origin = {31, 10}, extent = {{-29, 10}, {29, -10}}, textString = "txPoint"), Text(origin = {31, -30}, extent = {{-29, 10}, {29, -10}}, textString = "rxPoint"), Text(origin = {31, -70}, extent = {{-29, 10}, {29, -10}}, textString = "bitCounting")}, coordinateSystem(extent = {{-100, 140}, {80, -140}})),
  Documentation(info = "<html><head></head><body><div>鐘舵€佸涓嬶細</div><ol><li>Idle</li><li>Sync</li><li>Arb</li><li>Receive</li><li>SendIDE</li><li>Sendr0</li><li>SendDLC</li><li>ReceiveDLC</li><li>SendData</li><li>ReceiveData</li><li>SendCRC</li><li>ReceiveCRC</li><li>SendCRCE</li><li>ReceiveCRCE</li><li>SendACK</li><li>ReceiveACK</li><li>SendACKE</li><li>ReceiveACKE</li><li>SendEOF</li><li>ReceiveEOF</li></ol></body></html>"));
  end CANCoreStateMech;
  
    model ReadFromBufferStateMech
    Integer readData[10](start = fill(0, 10));
    Integer i(start = 0);
    Integer dataLength(start = 0);
    Integer frameInfo(start = 8);
    output Boolean IDE(start = false);
    output Boolean RTR(start = false);
    output Integer dataLengthout(start = 0);
    output Boolean DLC[4](start = fill(false, 4));
    output Boolean ID[11](start = fill(false, 11));
    output Boolean Data[64](start = fill(false, 64));
    output Boolean ArbData[12](start = fill(false, 12));
    Boolean CRC[15](start = fill(false, 15));
    Boolean CRCE(start = false);
    Boolean ACK(start = false);
    Boolean ACKE(start = false);
    Boolean EOF[7](start = fill(false, 7));
    Boolean finishReadingFromBuffer(start = false);
    Boolean startSend1(start = false);
    Boolean finishSendingToCAN(start = false);
    Modelica.StateGraph.InitialStep Wait(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-41, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal startSendSignal annotation(
        Placement(transformation(origin = {-21, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal ReadFromBuffer(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-1, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal finishReading annotation(
        Placement(transformation(origin = {19, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal sendingFrame(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {39, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal finishSendingFrame annotation(
        Placement(transformation(origin = {59, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression startToSend(y = startSend1) annotation(
        Placement(transformation(origin = {-41, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression finishReadingFromBuffer1(y = finishReadingFromBuffer) annotation(
        Placement(transformation(origin = {-1, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression finishSending(y = finishSendingToCAN) annotation(
        Placement(transformation(origin = {39, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
        Placement(transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, 10}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}})));
    //===========================================================
      Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -90}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
    parameter Boolean finishedSend = false;
    Modelica.Blocks.Interfaces.BooleanOutput finishReadStartSend annotation(
        Placement(transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}})));
    Integer temp(start = 0);
    output Boolean DLC2[4](start = fill(false, 4));
    algorithm
    when clk then
      if ReadFromBuffer.active then
        readTag := true;
      end if;
    end when;
    when not clk then
      if ReadFromBuffer.active then
        i := i + 1;
        readData[i] := readInt;
        readTag := false;
        if i >= dataLength + 2 then
          ID := utils.intToBoolArray(b=readData[1]*8+integer(readData[2]/32), N=11);
          for x in 1:8 loop
            Data[1+8*(x-1):8*x] := utils.intToBoolArray(b=readData[x+2], N=8);
          end for;
          ArbData := cat(1, ID, {RTR});
          CRC := fill(true, 15);
          CRCE := true;
          ACK := true;
          ACKE := true;
          EOF := fill(true, 7);
          finishReadingFromBuffer := true;
        end if;
      end if;
    end when;
    when Wait.active then
      frameInfo := 0;
      IDE := false;
      RTR := false;
      dataLength := 0;
      DLC := fill(false, 4);
      DLC2 := fill(false, 4);
      ID := fill(false, 11);
      Data := fill(false, 64);
      readData := fill(0, 10);
      ArbData := fill(false, 12);
      finishSendingToCAN := false;
      finishReadStartSend := false;
    end when;
    when ReadFromBuffer.active then
        startSend1 := false;
        i := 0;
        frameInfo := TxFrameInfo;
        IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
        RTR := if frameInfo>=128 then true else false;
        dataLength := mod(frameInfo, 16);
        temp := dataLength;
        
        DLC2[1] := if temp >= integer(2^3) then true else false;
        temp := if DLC2[1] then temp-integer(2^3) else temp;
        DLC2[2] := if temp >= integer(2^2) then true else false;
        temp := if DLC2[2] then temp-integer(2^2) else temp;
        DLC2[3] := if temp >= integer(2^1) then true else false;
        temp := if DLC2[3] then temp-integer(2^1) else temp;
        DLC2[4] := if temp >= integer(2^0) then true else false;
        temp := if DLC2[4] then temp-integer(2^0) else temp;
    
        DLC := utils.intToBoolArray(b=dataLength, N=4);
      end when;
    when sendingFrame.active then
//sendingFrame
      finishReadingFromBuffer := false;
      finishReadStartSend := true;
    end when;
    when startSend then
//sendingFrame
      startSend1 := true;
    end when;
    
    when finishedSend then
//sendingFrame
      finishSendingToCAN := true;
      finishReadStartSend := false;
    end when;
//===========================================================
    equation
      
      dataLengthout = dataLength*8;
      connect(Wait.outPort[1], startSendSignal.inPort) annotation(
        Line(points = {{-30.5, 2}, {-24.5, 2}}));
      connect(startSendSignal.outPort, ReadFromBuffer.inPort[1]) annotation(
        Line(points = {{-19.5, 2}, {-11.5, 2}}));
      connect(ReadFromBuffer.outPort[1], finishReading.inPort) annotation(
        Line(points = {{9.5, 2}, {15.5, 2}}));
      connect(finishReading.outPort, sendingFrame.inPort[1]) annotation(
        Line(points = {{20.5, 2}, {28.5, 2}}));
      connect(sendingFrame.outPort[1], finishSendingFrame.inPort) annotation(
        Line(points = {{49.5, 2}, {55.5, 2}}));
      connect(finishSendingFrame.outPort, Wait.inPort[1]) annotation(
        Line(points = {{60.5, 2}, {68.5, 2}, {68.5, 22}, {-61.5, 22}, {-61.5, 2}, {-51.5, 2}}));
      connect(startToSend.y, startSendSignal.condition) annotation(
        Line(points = {{-30, -32}, {-22, -32}, {-22, -10}}, color = {255, 0, 255}));
      connect(finishReadingFromBuffer1.y, finishReading.condition) annotation(
        Line(points = {{10, -32}, {18, -32}, {18, -10}}, color = {255, 0, 255}));
      connect(finishSending.y, finishSendingFrame.condition) annotation(
        Line(points = {{50, -32}, {58, -32}, {58, -10}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-80, 10}, {80, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startSend"), Text(origin = {-50, 40}, extent = {{-30, 10}, {30, -10}}, textString = "readInt"), Text(origin = {-50, 10}, extent = {{-30, 10}, {30, -10}}, textString = "readTag"), Text(origin = {-50, -20}, extent = {{-30, 10}, {30, -10}}, textString = "TxFrameInfo"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {-30, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishedSend"), Text(origin = {46, 50}, extent = {{-30, 10}, {30, -10}}, textString = "ID"), Text(origin = {46, 30}, extent = {{-30, 10}, {30, -10}}, textString = "IDE"), Text(origin = {46, 10}, extent = {{-30, 10}, {30, -10}}, textString = "RTR"), Text(origin = {46, -10}, extent = {{-30, 10}, {30, -10}}, textString = "DLC"), Text(origin = {46, -30}, extent = {{-30, 10}, {30, -10}}, textString = "dataLength"), Text(origin = {46, -50}, extent = {{-30, 10}, {30, -10}}, textString = "Data"), Text(origin = {46, 70}, extent = {{-30, 10}, {30, -10}}, textString = "ArbData"), Text(origin = {50, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishReadStartSend")}),
    Diagram(graphics));
    end ReadFromBufferStateMech;
  
  
    model WriteToBuffer
  Modelica.StateGraph.InitialStepWithSignal Wait(nOut = 1, nIn = 1)  annotation(
        Placement(transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal start annotation(
        Placement(transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Write(nIn = 1, nOut = 1)  annotation(
        Placement(transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finish annotation(
        Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput startWrite annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput finishWrite annotation(
        Placement(transformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerOutput writeData annotation(
        Placement(transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput writeSignal annotation(
        Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
    input Integer Data[10];
    input Integer writeDataLength;
    Integer count(start = 1);
    Boolean waitToWrite(start = false);
    Boolean delayToWait(start = false);
 Modelica.Blocks.Sources.BooleanExpression toWrite(y = waitToWrite)  annotation(
        Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
 Modelica.StateGraph.StepWithSignal Delay(nIn = 1, nOut = 1)  annotation(
        Placement(transformation(origin = {10, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
 Modelica.StateGraph.TransitionWithSignal finishDelay annotation(
        Placement(transformation(origin = {-10, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
 Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = delayToWait)  annotation(
        Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}})));
    initial algorithm
      finishWrite := false;
      writeSignal := false;
      writeData := 0;
    algorithm
      when startWrite then
        waitToWrite :=true;
      end when;
      when clk then
        if Wait.active then
          if finishWrite then
            finishWrite := false;
          end if;
        elseif Write.active then
          if delayToWait then
            delayToWait := false;
          end if;
          if count<= 10 then
            if not writeSignal then
              writeData := Data[count];
              writeSignal := true;
            else
              writeSignal := false;
              count := count + 1;
            end if;
          else
            finishWrite := true;
            count := 1;
          end if;
        elseif Delay.active then
          if waitToWrite then
            waitToWrite := false;
          end if;
          delayToWait := true;
        end if;
      end when;
    
    
    equation
  connect(Wait.outPort[1], start.inPort) annotation(
        Line(points = {{-20, 10}, {-14, 10}}));
  connect(start.outPort, Write.inPort[1]) annotation(
        Line(points = {{-8, 10}, {0, 10}}));
  connect(Write.outPort[1], finish.inPort) annotation(
        Line(points = {{20, 10}, {26, 10}}));
  connect(finishWrite, finish.condition) annotation(
        Line(points = {{90, 70}, {46, 70}, {46, -20}, {30, -20}, {30, -2}}, color = {255, 0, 255}));
 connect(toWrite.y, start.condition) annotation(
        Line(points = {{-18, -30}, {-10, -30}, {-10, -2}}, color = {255, 0, 255}));
 connect(finish.outPort, Delay.inPort[1]) annotation(
        Line(points = {{32, 10}, {40, 10}, {40, 50}, {22, 50}}));
 connect(Delay.outPort[1], finishDelay.inPort) annotation(
        Line(points = {{0, 50}, {-6, 50}}));
 connect(finishDelay.outPort, Wait.inPort[1]) annotation(
        Line(points = {{-12, 50}, {-50, 50}, {-50, 10}, {-40, 10}}));
 connect(booleanExpression.y, finishDelay.condition) annotation(
        Line(points = {{-18, 30}, {-10, 30}, {-10, 38}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startWrite"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "finishWrite"), Text(origin = {50, 30}, extent = {{-30, 10}, {30, -10}}, textString = "writeData"), Text(origin = {50, -10}, extent = {{-30, 10}, {30, -10}}, textString = "writeSignal")}),
  Diagram(graphics));
  end WriteToBuffer;
  
//==========================================================================================================================================================================================================================
    parameter Real F = 1e6 "Baud rate";
    parameter Real F_osc = 16e6 "Oscillator frequency";
    parameter Integer PROP_SEG_TQ = 7 "Propagation segment time quanta";
    parameter Integer PHASE_SEG2_TQ = 8 "Phase segment 2 time quanta";
    parameter Real T_bit = 1/F;
    parameter Integer N_tq = 1 + PROP_SEG_TQ + PHASE_SEG2_TQ;
    parameter Real T_Q = T_bit/N_tq;
    parameter Integer BRP = 1;
    parameter Boolean r0 = false;
  //=================================================
    Boolean CRC[15] = fill(false, 15);
    Boolean CRCE = true;
    Boolean ACK = true;
    Boolean ACKE = true;
    Boolean EOF[7] = fill(false, 7);
    Integer dlc_received(start = 0);
    Integer readDataLength(start = 0);
    Boolean crc_received[15](start = fill(false, 15));
    Boolean IDE_received(start = false);
    Boolean RTR_received(start = false);
    Boolean DLC_received[4](start = fill(false, 4));
    Boolean Data_received[64](start = fill(false, 64));
    Boolean Record[108](start = fill(false, 108));
    Boolean finishSendingToCAN(start = false);
    Boolean finishReceivingFromCAN(start = false);
  //=================================================
    Modelica.Blocks.Interfaces.BooleanOutput Tx annotation(
      Placement(transformation(origin = {330, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput Rx annotation(
      Placement(transformation(origin = {330, -116}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {90, -30}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
        Placement(transformation(origin = {-40, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
        Placement(transformation(origin = {-40, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
        Placement(transformation(origin = {-30, -120}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, -50}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
        Placement(transformation(origin = {-40, -140}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
  //=================================================
    Modelica.Blocks.Sources.BooleanPulse clk(period = 1/F_osc) annotation(
        Placement(transformation(origin = {12, -202}, extent = {{-10, -10}, {10, 10}})));
    CANCoreStateMech cANCoreStateMech annotation(
        Placement(transformation(origin = {224, 1.1111}, extent = {{-43, -66.8889}, {43, 66.8889}})));
    ReadFromBufferStateMech readFromBufferStateMech annotation(
      Placement(transformation(origin = {114, -134}, extent = {{-54, -54}, {54, 54}})));
  //=================================================
  initial algorithm
    cANCoreStateMech.sending := false;
    cANCoreStateMech.sendWaiting := false;
    cANCoreStateMech.dataLength := 0;
    cANCoreStateMech.readDataLength := 0;
    cANCoreStateMech.receiving := false;
    cANCoreStateMech.changeToReceive := false;
    cANCoreStateMech.noDataToSend := false;
  algorithm  //杩愯閫昏緫閮ㄥ垎
    when readFromBufferStateMech.finishReadStartSend then
      
      cANCoreStateMech.dataLength := readFromBufferStateMech.dataLengthout;
      cANCoreStateMech.readDataLength := 0;      //todo
      cANCoreStateMech.sendWaiting := true;
      if not cANCoreStateMech.receiving then
        cANCoreStateMech.sending := true;
      end if;
      if readFromBufferStateMech.dataLength == 0 then
        cANCoreStateMech.noDataToSend := true;
      else
        cANCoreStateMech.noDataToSend := false;
      end if;
    end when;
//=================================================
//鐘舵€侀€昏緫
    when cANCoreStateMech.txPoint then
      if cANCoreStateMech.canCoreState == 1 then
  //绌洪棽鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 2 then
//鍚屾鐘舵€?
        Tx := false;
//鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      finishSendingToCAN := false;
      finishReceivingFromCAN := false;
//      readFromBufferStateMech.finishedSend := false;
      elseif cANCoreStateMech.canCoreState == 3 then
//浠茶鍏煎彂閫佺姸鎬?
        Tx := readFromBufferStateMech.ArbData[cANCoreStateMech.bitCounting];
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 4 then
  //鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 5 then
//鍙戦€両DE鐘舵€?
        Tx := readFromBufferStateMech.IDE;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 6 then
//鍙戦€乺0鐘舵€?
        Tx := r0;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 7 then
//鍙戦€丏LC鐘舵€?
        Tx := readFromBufferStateMech.DLC[cANCoreStateMech.bitCounting - 14];
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 8 then
  //鎺ユ敹DLC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 9 then
//鍙戦€丏ata鐘舵€?
        Tx := readFromBufferStateMech.Data[cANCoreStateMech.bitCounting - 18];
      elseif cANCoreStateMech.canCoreState == 10 then
  //鎺ユ敹Data鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 11 then
//鍙戦€丆RC鐘舵€?
        Tx := CRC[cANCoreStateMech.bitCounting - 18 - readFromBufferStateMech.dataLength*8];
      elseif cANCoreStateMech.canCoreState == 12 then
  //鎺ユ敹CRC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 13 then
//鍙戦€丆RCE鐘舵€?
        Tx := CRCE;
      elseif cANCoreStateMech.canCoreState == 14 then
  //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 15 then
//鍙戦€丄CK鐘舵€?
        Tx := true;
      elseif cANCoreStateMech.canCoreState == 16 then
//鎺ユ敹ACK鐘舵€?
        Tx := false;
      elseif cANCoreStateMech.canCoreState == 17 then
//鍙戦€丄CKE鐘舵€?
        Tx := true;
      elseif cANCoreStateMech.canCoreState == 18 then
  //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 19 then
//鍙戦€丒OF鐘舵€?
        Tx := true;
        if cANCoreStateMech.bitCounting >= (43 + readFromBufferStateMech.dataLength*8) then
          cANCoreStateMech.sending := false;
          cANCoreStateMech.sendWaiting := false;
          finishSendingToCAN := true;
//readFromBufferStateMech.finishedSend := true;
        end if;
      elseif cANCoreStateMech.canCoreState == 20 then
//鎺ユ敹EOF鐘舵€?
        if cANCoreStateMech.bitCounting >= (43 + readDataLength) then
          cANCoreStateMech.receiving := false;
          finishReceivingFromCAN := true;
          cANCoreStateMech.changeToReceive := false;
        end if;
      end if;
    end when;
//=========================================================================================================
    when cANCoreStateMech.rxPoint then
      if cANCoreStateMech.canCoreState == 1 then
  //绌洪棽鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 2 then
  //鍚屾鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 3 then
//浠茶鍏煎彂閫佺姸鎬?
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鑻x涓洪珮鑰孯x涓轰綆锛屽垯鐩存帴杩涘叆鎺ユ敹閫昏緫
        Record[cANCoreStateMech.bitCounting] := Rx;
        if Tx and not Rx then
          cANCoreStateMech.changeToReceive := true;
          cANCoreStateMech.sending := false;
          cANCoreStateMech.receiving := true;
        end if;
      elseif cANCoreStateMech.canCoreState == 4 then
//鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
  //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif cANCoreStateMech.canCoreState == 5 then
  //鍙戦€両DE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 6 then
  //鍙戦€乺0鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 7 then
  //鍙戦€丏LC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 8 then
//鎺ユ敹DLC鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
        dlc_received := dlc_received*2 + utils.boolToInt(Rx);
//璁板綍DLC
        if cANCoreStateMech.bitCounting >= 18 then
          readDataLength := dlc_received*8;
//鍥涗釜bit鍚庢洿鏂版暣甯ч暱搴?
          if dlc_received == 0 then
            cANCoreStateMech.noDataToReceive := true;
          else
            cANCoreStateMech.noDataToReceive := false;
          end if;
        end if;
      elseif cANCoreStateMech.canCoreState == 9 then
  //鍙戦€丏ata鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 10 then
  //鎺ユ敹Data鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 11 then
  //鍙戦€丆RC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 12 then
//鎺ユ敹CRC鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
        crc_received[cANCoreStateMech.bitCounting - 18 - readDataLength] := Rx;
  //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif cANCoreStateMech.canCoreState == 13 then
  //鍙戦€丆RCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 14 then
  //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 15 then
  //鍙戦€丄CK鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 16 then
  //鎺ユ敹ACK鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 17 then
  //鍙戦€丄CKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 18 then
  //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 19 then
  //鍙戦€丒OF鐘舵€?
elseif cANCoreStateMech.canCoreState == 20 then
//鎺ユ敹EOF鐘舵€?
        if cANCoreStateMech.bitCounting >= (43+readDataLength) then
          cANCoreStateMech.receiving := false;
          cANCoreStateMech.changeToReceive := false;
          IDE_received := Record[12];
          RTR_received := Record[13];
          DLC_received := Record[14:17];
          if not cANCoreStateMech.noDataToReceive then
            Data_received[1:readDataLength] := Record[18:17 + readDataLength];
          end if;
          cANCoreStateMech.noDataToReceive := false;
          finishReceivingFromCAN := true;
        end if;
      end if;
    end when;
  equation
    connect(clk.y, readFromBufferStateMech.clk) annotation(
      Line(points = {{24, -202}, {40, -202}, {40, -161}, {65, -161}}, color = {255, 0, 255}));
    connect(TxFrameInfo, readFromBufferStateMech.TxFrameInfo) annotation(
      Line(points = {{-40, -80}, {40, -80}, {40, -145}, {65, -145}}, color = {255, 127, 0}));
    connect(readFromBufferStateMech.readTag, readTag) annotation(
      Line(points = {{65, -129}, {20, -129}, {20, -120}, {-30, -120}}, color = {255, 0, 255}));
    connect(readInt, readFromBufferStateMech.readInt) annotation(
      Line(points = {{-40, -140}, {32, -140}, {32, -112}, {65, -112}}, color = {255, 127, 0}));
    connect(startSend, readFromBufferStateMech.startSend) annotation(
      Line(points = {{-40, 40}, {24, 40}, {24, -96}, {65, -96}}, color = {255, 0, 255}));
    annotation(
      Icon(graphics = {Rectangle(fillColor = {85, 85, 0}, fillPattern = FillPattern.Horizontal, extent = {{-80, 80}, {80, -80}}), Text(origin = {70, 30}, extent = {{-10, 10}, {10, -10}}, textString = "Tx"), Text(origin = {70, -30}, extent = {{-10, 10}, {10, -10}}, textString = "Rx"), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-40, 71}, extent = {{-40, 9}, {40, -9}}, textString = "startSend"), Text(origin = {-40, 51}, extent = {{-40, 9}, {40, -9}}, textString = "TxFrameInfo"), Text(origin = {-40, -49}, extent = {{-40, 9}, {40, -9}}, textString = "readTag"), Text(origin = {-40, -69}, extent = {{-40, 9}, {40, -9}}, textString = "readInt")}),
      Diagram(graphics = {Rectangle(origin = {150, -90}, extent = {{-170, 190}, {170, -190}})}, coordinateSystem(extent = {{-60, 100}, {340, -280}})),
  Documentation(info = "<html><head></head><body><div><div><br></div></div><div><ol><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Idle</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Sync</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Arb</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Receive</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendIDE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">Sendr0</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendDLC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveDLC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendData</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveData</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendCRC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveCRC</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendCRCE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveCRCE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendACK</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveACK</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendACKE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveACKE</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">SendEOF</li><li style=\"font-family: 瀹嬩綋; font-size: 12px;\">ReceiveEOF</li></ol></div></body></html>"));
  end CANCore3;

  package Core
    model RxSampler
      extends Modelica.Blocks.Icons.DiscreteBlock;
      parameter Boolean y_start = true "Initial value of output signal";
      Modelica.Blocks.Interfaces.BooleanInput u "Connector with a Boolean input signal" annotation(
        Placement(transformation(origin = {0, 60}, extent = {{-140, -20}, {-100, 20}}), iconTransformation(origin = {0, 64}, extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y "Connector with a Boolean output signal" annotation(
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger input" annotation(
        Placement(transformation(origin = {0, -118}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanInput v annotation(
        Placement(transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}})));
    equation
      when trigger then
        y = (u and not v) or (v and not u);
      end when;
    initial equation
      y = y_start;
    end RxSampler;
  
    model TQCounter
      parameter Integer N_tq = 16;
      Modelica.Blocks.Interfaces.BooleanInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when count then
        y := y + 1;
      end when;
      when reset then
        y := 0;
      end when;
      when y >= N_tq then
        y := 0;
      end when;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%N_tq")}));
    end TQCounter;
  
    model TQTimer
      parameter Real TQ = 1;
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Real x(start = 0);
    equation
      der(x) = 1;
      when reset then
        reinit(x, 0);
      end when;
      when x >= TQ then
        reinit(x, 0);
      end when;
      y = x < TQ/2;
      annotation(
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {0, -70}, extent = {{-60, 10}, {60, -10}}, textString = "%TQ")}));
    end TQTimer;
  
    model BitCounter
      Modelica.Blocks.Interfaces.IntegerInput count annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.IntegerOutput y annotation(
        Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Interfaces.BooleanInput reset annotation(
        Placement(transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial algorithm
      y := 0;
    algorithm
      when reset then
        y := 0;
      elsewhen count == 0 then
        y := pre(y) + 1;
      end when;
      annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})),
        Diagram(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}})}),
        Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 50}, extent = {{-60, 10}, {60, -10}}, textString = "%name")}));
    end BitCounter;
  
    
  
    model CANCoreStateMech
    //========================================================================
    parameter Real T_Q = 1;
    parameter Integer N_tq = 16;
    parameter Integer PROP_SEG_TQ = 7;
    //========================================================================
  Modelica.StateGraph.InitialStep Idle(nIn = 2, nOut = 2) annotation(
        Placement(transformation(origin = {-259, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal whenRxLow annotation(
        Placement(transformation(origin = {-187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenRxFalse(y =  finishReading) annotation(
        Placement(transformation(origin = {-211, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sync(nIn = 3, nOut = 2) annotation(
        Placement(transformation(origin = {-167, 67}, extent = {{-10, -10}, {10, 10}})));
  BitCounter bitCounter annotation(
        Placement(transformation(origin = {-173, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal bit1 annotation(
        Placement(transformation(origin = {-139, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenbit1(y = (tQCounter.y >= N_tq - 1) and sending) annotation(
        Placement(transformation(origin = {-153, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Arb(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {-117, 67}, extent = {{-10, -10}, {10, 10}})));
  TQCounter tQCounter(N_tq = N_tq) annotation(
        Placement(transformation(origin = {-191, 11}, extent = {{-10, -10}, {10, 10}})));
  TQTimer tQTimer(TQ = T_Q) annotation(
        Placement(transformation(origin = {-211, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Receive(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {-73, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal toReveive annotation(
        Placement(transformation(origin = {-93, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startReceiving annotation(
        Placement(transformation(origin = {-139, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenBit1AndNotSending(y = (tQCounter.y >= N_tq - 1) and not sending) annotation(
        Placement(transformation(origin = {-153, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal arbSuccess annotation(
        Placement(transformation(origin = {-93, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount13(y = (bitCounter.y >= 13) and sending) annotation(
        Placement(transformation(origin = {-117, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendIDE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-73, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ideSend annotation(
        Placement(transformation(origin = {-53, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount14(y = bitCounter.y >= 14) annotation(
        Placement(transformation(origin = {-73, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sendr0(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-33, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount15(y = bitCounter.y >= 15) annotation(
        Placement(transformation(origin = {-33, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal r0Send annotation(
        Placement(transformation(origin = {-13, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcSend annotation(
        Placement(transformation(origin = {27, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19(y = (bitCounter.y >= 19) and not noDataToSend) annotation(
        Placement(transformation(origin = {7, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveDLC(nIn = 1, nOut = 2) annotation(
        Placement(transformation(origin = {7, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ider0Received annotation(
        Placement(transformation(origin = {-13, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcReceived annotation(
        Placement(transformation(origin = {27, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveData(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {47, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataSend annotation(
        Placement(transformation(origin = {67, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataReceived annotation(
        Placement(transformation(origin = {67, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveCRC(nIn = 2, nOut = 1) annotation(
        Placement(transformation(origin = {87, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataSend annotation(
        Placement(transformation(origin = {67, 25}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndnoData(y = (bitCounter.y >= 19) and noDataToSend) annotation(
        Placement(transformation(origin = {7, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataReveive annotation(
        Placement(transformation(origin = {67, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcSend annotation(
        Placement(transformation(origin = {107, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceSend annotation(
        Placement(transformation(origin = {147, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackSend annotation(
        Placement(transformation(origin = {187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeSend annotation(
        Placement(transformation(origin = {227, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendEOF(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {247, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofSend annotation(
        Placement(transformation(origin = {267, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength(y = bitCounter.y >= (19 + dataLength*8)) annotation(
        Placement(transformation(origin = {47, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength(y = bitCounter.y >= (34 + dataLength*8)) annotation(
        Placement(transformation(origin = {87, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength(y = bitCounter.y >= (35 + dataLength*8)) annotation(
        Placement(transformation(origin = {127, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength(y = bitCounter.y >= (36 + dataLength*8)) annotation(
        Placement(transformation(origin = {167, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength(y = bitCounter.y >= (37 + dataLength*8)) annotation(
        Placement(transformation(origin = {207, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength(y = (bitCounter.y >= (44 + dataLength*8)) and not sendWaiting) annotation(
        Placement(transformation(origin = {247, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcReceived annotation(
        Placement(transformation(origin = {107, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step ReceiveCRCE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {127, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceReveived annotation(
        Placement(transformation(origin = {147, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACK(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {167, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackReceived annotation(
        Placement(transformation(origin = {187, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACKE(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {207, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeReceived annotation(
        Placement(transformation(origin = {227, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveEOF(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {247, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofReceived annotation(
        Placement(transformation(origin = {351, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending1 annotation(
        Placement(transformation(origin = {351, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression toReceive1(y = changeToReceive) annotation(
        Placement(transformation(origin = {-117, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength1(y = bitCounter.y >= (19 + readDataLength)) annotation(
        Placement(transformation(origin = {46, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength1(y = bitCounter.y >= (34 + readDataLength)) annotation(
        Placement(transformation(origin = {86, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength1(y = bitCounter.y >= (35 + readDataLength)) annotation(
        Placement(transformation(origin = {126, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength1(y = bitCounter.y >= (36 + readDataLength)) annotation(
        Placement(transformation(origin = {166, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength1(y = bitCounter.y >= (37 + readDataLength)) annotation(
        Placement(transformation(origin = {206, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength1(y = finishWritingToBuffer and not sendWaiting) annotation(
        Placement(transformation(origin = {330, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = finishWritingToBuffer and sendWaiting) annotation(
        Placement(transformation(origin = {330, -68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep SYNC_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-205, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ1 annotation(
        Placement(transformation(origin = {-181, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step PROP_SEG(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-161, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ2 annotation(
        Placement(transformation(origin = {-139, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ3 annotation(
        Placement(transformation(origin = {-99, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = tQCounter.y >= 1) annotation(
        Placement(transformation(origin = {-201, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = tQCounter.y >= PROP_SEG_TQ + 1) annotation(
        Placement(transformation(origin = {-161, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = tQCounter.y == 0) annotation(
        Placement(transformation(origin = {-119, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal PHASE_SEG2(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-119, -74}, extent = {{-10, -10}, {10, 10}})));
  //======================================================================================
      //======================================================================================
    input Integer dataLength;
    input Integer readDataLength;
    input Boolean sending;
    input Boolean receiving;
    input Boolean changeToReceive;
    input Boolean noDataToSend;
    input Boolean sendWaiting;
    input Boolean startReadingFromBuffer;
    input Boolean finishReadingFromBuffer;
    input Boolean finishWritingToBuffer;
    output Boolean noDataToReceive;
    output Integer canCoreState(start = 1);
    output Boolean txPoint(start = false);
    output Boolean rxPoint(start = false);
    output Integer bitCounting(start = 0);
  //======================================================================================
      Modelica.Blocks.Sources.BooleanExpression bitCount19AndNoDataToR(y = (bitCounter.y >= 19) and noDataToReceive)  annotation(
        Placement(transformation(origin = {6, -72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y = (bitCounter.y >= 19) and not noDataToReceive)  annotation(
        Placement(transformation(origin = {6, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReadBuffer(nOut = 1, nIn = 1)  annotation(
        Placement(transformation(origin = {-216, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Transition read(condition = startReadingFromBuffer)  annotation(
        Placement(transformation(origin = {-236, 66}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Transition recei(condition = not Rx)  annotation(
        Placement(transformation(origin = {-236, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step WriteBuffer(nIn = 1, nOut = 2)  annotation(
        Placement(transformation(origin = {290, -12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Transition startWritingToBuffer(condition = (bitCounter.y >= (44 + readDataLength)))  annotation(
        Placement(transformation(origin = {270, -12}, extent = {{-10, -10}, {10, 10}})));
    initial algorithm
      canCoreState := 1;
    algorithm
      when Idle.active then
        canCoreState := 1;
      end when;
      when Sync.active then
        canCoreState := 2;
      end when;
      when Arb.active then
        canCoreState := 3;
      end when;
      when Receive.active then
        canCoreState := 4;
      end when;
      when SendIDE.active then
        canCoreState := 5;
      end when;
      when Sendr0.active then
        canCoreState := 6;
      end when;
      when SendDLC.active then
        canCoreState := 7;
      end when;
      when ReceiveDLC.active then
        canCoreState := 8;
      end when;
      when SendData.active then
        canCoreState := 9;
      end when;
      when ReceiveData.active then
        canCoreState := 10;
      end when;
      when SendCRC.active then
        canCoreState := 11;
      end when;
      when ReceiveCRC.active then
        canCoreState := 12;
      end when;
      when SendCRCE.active then
        canCoreState := 13;
      end when;
      when ReceiveCRCE.active then
        canCoreState := 14;
      end when;
      when SendACK.active then
        canCoreState := 15;
      end when;
      when ReceiveACK.active then
        canCoreState := 16;
      end when;
      when SendACKE.active then
        canCoreState := 17;
      end when;
      when ReceiveACKE.active then
        canCoreState := 18;
      end when;
      when SendEOF.active then
        canCoreState := 19;
      end when;
      when ReceiveEOF.active then
        canCoreState := 20;
      end when;
      when ReadBuffer.active then
        canCoreState := 21;
      end when;
      when WriteBuffer.active then
        canCoreState := 22;
      end when;
    equation
      txPoint = (tQCounter.y == 1);
      rxPoint = (tQCounter.y == PROP_SEG_TQ + 1);
      bitCounter.y = bitCounting; 
      connect(whenRxFalse.y, whenRxLow.condition) annotation(
        Line(points = {{-200, 41}, {-188, 41}, {-188, 55}}, color = {255, 0, 255}));
      connect(whenRxLow.outPort, Sync.inPort[1]) annotation(
        Line(points = {{-185.5, 67}, {-177.5, 67}}));
      connect(Sync.active, tQCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-191, 23}, {-191, 18}}, color = {255, 0, 255}));
      connect(Sync.active, tQTimer.reset) annotation(
        Line(points = {{-167, 56}, {-167, 23}, {-211, 23}, {-211, 18}}, color = {255, 0, 255}));
      connect(tQTimer.y, tQCounter.count) annotation(
        Line(points = {{-204, 11}, {-198, 11}}, color = {255, 0, 255}));
      connect(Sync.outPort[1], bit1.inPort) annotation(
        Line(points = {{-156.5, 67}, {-143, 67}}));
      connect(whenbit1.y, bit1.condition) annotation(
        Line(points = {{-142, 41}, {-140, 41}, {-140, 55}}, color = {255, 0, 255}));
      connect(bit1.outPort, Arb.inPort[1]) annotation(
        Line(points = {{-137.5, 67}, {-127.5, 67}}));
      connect(tQCounter.y, bitCounter.count) annotation(
        Line(points = {{-184, 11}, {-180, 11}}, color = {255, 127, 0}));
      connect(Arb.outPort[1], toReveive.inPort) annotation(
        Line(points = {{-106.5, 67}, {-102.5, 67}, {-102.5, -13}, {-97, -13}}));
      connect(toReveive.outPort, Receive.inPort[1]) annotation(
        Line(points = {{-91.5, -13}, {-83.5, -13}}));
      connect(Sync.active, bitCounter.reset) annotation(
        Line(points = {{-167, 56}, {-167, 22}, {-173, 22}, {-173, 18}}, color = {255, 0, 255}));
      connect(Sync.outPort[2], startReceiving.inPort) annotation(
        Line(points = {{-156.5, 67}, {-150.5, 67}, {-150.5, -13}, {-143, -13}}));
      connect(startReceiving.outPort, Receive.inPort[2]) annotation(
        Line(points = {{-137.5, -13}, {-107.5, -13}, {-107.5, -1}, {-87.5, -1}, {-87.5, -13}, {-83.5, -13}}));
      connect(whenBit1AndNotSending.y, startReceiving.condition) annotation(
        Line(points = {{-142, -35}, {-139, -35}, {-139, -25}}, color = {255, 0, 255}));
      connect(Arb.outPort[2], arbSuccess.inPort) annotation(
        Line(points = {{-106.5, 67}, {-96.5, 67}}));
      connect(bitCount13.y, arbSuccess.condition) annotation(
        Line(points = {{-106, 41}, {-94, 41}, {-94, 55}}, color = {255, 0, 255}));
      connect(arbSuccess.outPort, SendIDE.inPort[1]) annotation(
        Line(points = {{-91.5, 67}, {-83.5, 67}}));
      connect(bitCount14.y, ideSend.condition) annotation(
        Line(points = {{-62, 41}, {-54, 41}, {-54, 55}}, color = {255, 0, 255}));
      connect(SendIDE.outPort[1], ideSend.inPort) annotation(
        Line(points = {{-62.5, 67}, {-56.5, 67}}));
      connect(ideSend.outPort, Sendr0.inPort[1]) annotation(
        Line(points = {{-51.5, 67}, {-43.5, 67}}));
      connect(Sendr0.outPort[1], r0Send.inPort) annotation(
        Line(points = {{-22.5, 67}, {-16.5, 67}}));
      connect(SendDLC.outPort[1], dlcSend.inPort) annotation(
        Line(points = {{17.5, 67}, {23.5, 67}}));
      connect(r0Send.outPort, SendDLC.inPort[1]) annotation(
        Line(points = {{-11.5, 67}, {-3.5, 67}}));
      connect(ider0Received.outPort, ReceiveDLC.inPort[1]) annotation(
        Line(points = {{-11.5, -13}, {-3.5, -13}}));
      connect(Receive.outPort[1], ider0Received.inPort) annotation(
        Line(points = {{-62.5, -13}, {-16.5, -13}}));
      connect(ReceiveDLC.outPort[1], dlcReceived.inPort) annotation(
        Line(points = {{17.5, -13}, {23.5, -13}}));
      connect(dlcSend.outPort, SendData.inPort[1]) annotation(
        Line(points = {{28.5, 67}, {36.5, 67}}));
      connect(dlcReceived.outPort, ReceiveData.inPort[1]) annotation(
        Line(points = {{28.5, -13}, {36.5, -13}}));
      connect(SendData.outPort[1], dataSend.inPort) annotation(
        Line(points = {{57.5, 67}, {63.5, 67}}));
      connect(ReceiveData.outPort[1], dataReceived.inPort) annotation(
        Line(points = {{57.5, -13}, {63.5, -13}}));
      connect(dataReceived.outPort, ReceiveCRC.inPort[1]) annotation(
        Line(points = {{68.5, -13}, {76.5, -13}}));
      connect(dataSend.outPort, SendCRC.inPort[1]) annotation(
        Line(points = {{68.5, 67}, {76.5, 67}}));
      connect(noDataSend.outPort, SendCRC.inPort[2]) annotation(
        Line(points = {{68.5, 25}, {71, 25}, {71, 67}, {77, 67}}));
      connect(SendDLC.outPort[2], noDataSend.inPort) annotation(
        Line(points = {{17.5, 67}, {19.5, 67}, {19.5, 25}, {63.5, 25}}));
      connect(bitCount19AndnoData.y, noDataSend.condition) annotation(
        Line(points = {{18, 11}, {58, 11}, {58, 12}, {66, 12}, {66, 13}}, color = {255, 0, 255}));
      connect(ReceiveDLC.outPort[2], noDataReveive.inPort) annotation(
        Line(points = {{17.5, -13}, {19.5, -13}, {19.5, -53}, {63.5, -53}}));
      connect(noDataReveive.outPort, ReceiveCRC.inPort[2]) annotation(
        Line(points = {{68.5, -53}, {71, -53}, {71, -13}, {77, -13}}));
      connect(bitCount19PlusDataLength.y, dataSend.condition) annotation(
        Line(points = {{58, 41}, {62, 41}, {62, 54}, {66, 54}, {66, 55}}, color = {255, 0, 255}));
      connect(SendCRC.outPort[1], crcSend.inPort) annotation(
        Line(points = {{97.5, 67}, {103.5, 67}}));
      connect(crcSend.outPort, SendCRCE.inPort[1]) annotation(
        Line(points = {{108.5, 67}, {116.5, 67}}));
      connect(SendCRCE.outPort[1], crceSend.inPort) annotation(
        Line(points = {{137.5, 67}, {143.5, 67}}));
      connect(crceSend.outPort, SendACK.inPort[1]) annotation(
        Line(points = {{148.5, 67}, {156.5, 67}}));
      connect(SendACK.outPort[1], ackSend.inPort) annotation(
        Line(points = {{177.5, 67}, {183.5, 67}}));
      connect(ackSend.outPort, SendACKE.inPort[1]) annotation(
        Line(points = {{188.5, 67}, {196.5, 67}}));
      connect(SendACKE.outPort[1], ackeSend.inPort) annotation(
        Line(points = {{217.5, 67}, {223.5, 67}}));
      connect(ackeSend.outPort, SendEOF.inPort[1]) annotation(
        Line(points = {{228.5, 67}, {236.5, 67}}));
      connect(SendEOF.outPort[1], eofSend.inPort) annotation(
        Line(points = {{257.5, 67}, {263.5, 67}}));
      connect(bitCount34PlusDataLength.y, crcSend.condition) annotation(
        Line(points = {{98, 41}, {102, 41}, {102, 55}, {106, 55}}, color = {255, 0, 255}));
      connect(bitCount19.y, dlcSend.condition) annotation(
        Line(points = {{18, 41}, {22, 41}, {22, 55}, {26, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, r0Send.condition) annotation(
        Line(points = {{-22, 41}, {-18, 41}, {-18, 55}, {-14, 55}}, color = {255, 0, 255}));
      connect(bitCount15.y, ider0Received.condition) annotation(
        Line(points = {{-22, 41}, {-17, 41}, {-17, -25}, {-13, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength.y, crceSend.condition) annotation(
        Line(points = {{138, 41}, {142, 41}, {142, 55}, {146, 55}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength.y, ackSend.condition) annotation(
        Line(points = {{178, 41}, {182, 41}, {182, 55}, {186, 55}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength.y, ackeSend.condition) annotation(
        Line(points = {{218, 41}, {222, 41}, {222, 55}, {226, 55}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength.y, eofSend.condition) annotation(
        Line(points = {{258, 41}, {262, 41}, {262, 55}, {266, 55}}, color = {255, 0, 255}));
      connect(ReceiveCRC.outPort[1], crcReceived.inPort) annotation(
        Line(points = {{97.5, -13}, {103.5, -13}}));
      connect(crcReceived.outPort, ReceiveCRCE.inPort[1]) annotation(
        Line(points = {{108.5, -13}, {116.5, -13}}));
      connect(ReceiveCRCE.outPort[1], crceReveived.inPort) annotation(
        Line(points = {{137.5, -13}, {143.5, -13}}));
      connect(crceReveived.outPort, ReceiveACK.inPort[1]) annotation(
        Line(points = {{148.5, -13}, {156.5, -13}}));
      connect(ReceiveACK.outPort[1], ackReceived.inPort) annotation(
        Line(points = {{177.5, -13}, {183.5, -13}}));
      connect(ackReceived.outPort, ReceiveACKE.inPort[1]) annotation(
        Line(points = {{188.5, -13}, {196.5, -13}}));
      connect(ReceiveACKE.outPort[1], ackeReceived.inPort) annotation(
        Line(points = {{217.5, -13}, {223.5, -13}}));
      connect(ackeReceived.outPort, ReceiveEOF.inPort[1]) annotation(
        Line(points = {{228.5, -13}, {236.5, -13}}));
      connect(eofSend.outPort, Idle.inPort[1]) annotation(
        Line(points = {{268.5, 67}, {280.5, 67}, {280.5, 87}, {-287.5, 87}, {-287.5, 67}, {-270, 67}}));
      connect(eofReceived.outPort, Idle.inPort[2]) annotation(
        Line(points = {{352.5, -13}, {368.5, -13}, {368.5, 87}, {-287.5, 87}, {-287.5, 67}, {-270, 67}}));
      connect(waitSending1.outPort, Sync.inPort[2]) annotation(
        Line(points = {{352.5, -53}, {359, -53}, {359, 83}, {-181, 83}, {-181, 67}, {-177, 67}}));
      connect(recei.outPort, Sync.inPort[3]) annotation(
        Line(points = {{-234, 30}, {-182, 30}, {-182, 68}, {-178, 68}}));
      connect(bitCount19PlusDataLength1.y, dataReceived.condition) annotation(
        Line(points = {{57, -40}, {67, -40}, {67, -25}}, color = {255, 0, 255}));
      connect(bitCount34PlusDataLength1.y, crcReceived.condition) annotation(
        Line(points = {{97, -40}, {107, -40}, {107, -25}}, color = {255, 0, 255}));
      connect(bitCount35PlusDataLength1.y, crceReveived.condition) annotation(
        Line(points = {{137, -40}, {147, -40}, {147, -25}}, color = {255, 0, 255}));
      connect(bitCount36PlusDataLength1.y, ackReceived.condition) annotation(
        Line(points = {{177, -40}, {187, -40}, {187, -25}}, color = {255, 0, 255}));
      connect(bitCount37PlusDataLength1.y, ackeReceived.condition) annotation(
        Line(points = {{217, -40}, {227, -40}, {227, -25}}, color = {255, 0, 255}));
      connect(bitCount44PlusDataLength1.y, eofReceived.condition) annotation(
        Line(points = {{341, -40}, {351, -40}, {351, -25}}, color = {255, 0, 255}));
      connect(booleanExpression4.y, waitSending1.condition) annotation(
        Line(points = {{341, -68}, {351, -68}, {351, -65}}, color = {255, 0, 255}));
      connect(toReceive1.y, toReveive.condition) annotation(
        Line(points = {{-106, -35}, {-94, -35}, {-94, -25}}, color = {255, 0, 255}));
      connect(SYNC_SEG.outPort[1], TQ1.inPort) annotation(
        Line(points = {{-194.5, -74}, {-184.5, -74}}));
      connect(TQ1.outPort, PROP_SEG.inPort[1]) annotation(
        Line(points = {{-179.5, -74}, {-171.5, -74}}));
      connect(PROP_SEG.outPort[1], TQ2.inPort) annotation(
        Line(points = {{-150.5, -74}, {-142.5, -74}}));
      connect(TQ3.outPort, SYNC_SEG.inPort[1]) annotation(
        Line(points = {{-97.5, -74}, {-93.5, -74}, {-93.5, -94}, {-221.5, -94}, {-221.5, -74}, {-215.5, -74}}));
      connect(booleanExpression1.y, TQ1.condition) annotation(
        Line(points = {{-190, -106}, {-182, -106}, {-182, -86}}, color = {255, 0, 255}));
      connect(booleanExpression2.y, TQ2.condition) annotation(
        Line(points = {{-150, -106}, {-140, -106}, {-140, -86}}, color = {255, 0, 255}));
      connect(booleanExpression3.y, TQ3.condition) annotation(
        Line(points = {{-108, -106}, {-100, -106}, {-100, -86}}, color = {255, 0, 255}));
      connect(TQ2.outPort, PHASE_SEG2.inPort[1]) annotation(
        Line(points = {{-137.5, -74}, {-129.5, -74}}));
      connect(PHASE_SEG2.outPort[1], TQ3.inPort) annotation(
        Line(points = {{-108.5, -74}, {-102.5, -74}}));
  connect(bitCount19AndNoDataToR.y, noDataReveive.condition) annotation(
        Line(points = {{17, -72}, {65, -72}, {65, -64}, {68, -64}}, color = {255, 0, 255}));
  connect(booleanExpression5.y, dlcReceived.condition) annotation(
        Line(points = {{18, -38}, {28, -38}, {28, -24}}, color = {255, 0, 255}));
  connect(ReadBuffer.outPort[1], whenRxLow.inPort) annotation(
        Line(points = {{-205.5, 66}, {-196.75, 66}, {-196.75, 68}, {-190, 68}}));
  connect(Idle.outPort[1], read.inPort) annotation(
        Line(points = {{-248.5, 67}, {-240, 67}, {-240, 66}}));
  connect(read.outPort, ReadBuffer.inPort[1]) annotation(
        Line(points = {{-234.5, 66}, {-226, 66}}));
  connect(Idle.outPort[2], recei.inPort) annotation(
        Line(points = {{-248, 68}, {-244, 68}, {-244, 30}, {-240, 30}}));
  connect(ReceiveEOF.outPort[1], startWritingToBuffer.inPort) annotation(
        Line(points = {{258, -12}, {266, -12}}));
  connect(startWritingToBuffer.outPort, WriteBuffer.inPort[1]) annotation(
        Line(points = {{272, -12}, {280, -12}}));
  connect(WriteBuffer.outPort[1], eofReceived.inPort) annotation(
        Line(points = {{300, -12}, {348, -12}}));
  connect(WriteBuffer.outPort[2], waitSending1.inPort) annotation(
        Line(points = {{300, -12}, {310, -12}, {310, -52}, {348, -52}}));
    annotation(
        Diagram(coordinateSystem(extent = {{-240, 100}, {300, -120}}), graphics),
  Icon(graphics = {Rectangle(origin = {-10, 70}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 70}, {70, -70}}), Text(origin = {-10, 150}, extent = {{-70, 10}, {70, -10}}, textString = "%name"), Text(origin = {-10, 10}, extent = {{-70, 10}, {70, -10}}, textString = "%canCoreState")}, coordinateSystem(extent = {{-80, 160}, {60, 0}})),
  Documentation(info = "<html><head></head><body><div>鐘舵€佸涓嬶細</div><ol><li>Idle</li><li>Sync</li><li>Arb</li><li>Receive</li><li>SendIDE</li><li>Sendr0</li><li>SendDLC</li><li>ReceiveDLC</li><li>SendData</li><li>ReceiveData</li><li>SendCRC</li><li>ReceiveCRC</li><li>SendCRCE</li><li>ReceiveCRCE</li><li>SendACK</li><li>ReceiveACK</li><li>SendACKE</li><li>ReceiveACKE</li><li>SendEOF</li><li>ReceiveEOF</li></ol></body></html>"));
  end CANCoreStateMech;
  
    model ReadFromBufferStateMech
    Integer readData[10](start = fill(0, 10));
    Integer i(start = 0);
    Integer dataLength(start = 0);
    Integer frameInfo(start = 8);
    output Boolean IDE(start = false);
    output Boolean RTR(start = false);
    output Integer dataLengthout(start = 0);
    output Boolean DLC[4](start = fill(false, 4));
    output Boolean ID[11](start = fill(false, 11));
    output Boolean Data[64](start = fill(false, 64));
    output Boolean ArbData[12](start = fill(false, 12));
    Boolean CRC[15](start = fill(false, 15));
    Boolean CRCE(start = false);
    Boolean ACK(start = false);
    Boolean ACKE(start = false);
    Boolean EOF[7](start = fill(false, 7));
    Boolean finishReadingFromBuffer(start = false);
    Boolean startSend1(start = false);
    Boolean finishSendingToCAN(start = false);
    Modelica.StateGraph.InitialStep Wait(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-41, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal startSendSignal annotation(
        Placement(transformation(origin = {-21, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal ReadFromBuffer(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {-1, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal finishReading annotation(
        Placement(transformation(origin = {19, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.StepWithSignal sendingFrame(nIn = 1, nOut = 1) annotation(
        Placement(transformation(origin = {39, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.StateGraph.TransitionWithSignal finishSendingFrame annotation(
        Placement(transformation(origin = {59, 2}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression startToSend(y = startSend1) annotation(
        Placement(transformation(origin = {-41, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression finishReadingFromBuffer1(y = finishReadingFromBuffer) annotation(
        Placement(transformation(origin = {-1, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.BooleanExpression finishSending(y = finishSendingToCAN) annotation(
        Placement(transformation(origin = {39, -32}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput startSend annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput readInt annotation(
        Placement(transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput readTag annotation(
        Placement(transformation(origin = {-90, -10}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-90, 10}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}})));
    //===========================================================
      Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -90}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
    parameter Boolean finishedSend = false;
    Modelica.Blocks.Interfaces.BooleanOutput finishReadStartSend annotation(
        Placement(transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}})));
    Integer temp(start = 0);
    output Boolean DLC2[4](start = fill(false, 4));
    algorithm
    when clk then
      if ReadFromBuffer.active then
        readTag := true;
      end if;
    end when;
    when not clk then
      if ReadFromBuffer.active then
        i := i + 1;
        readData[i] := readInt;
        readTag := false;
        if i >= dataLength + 2 then
          ID := utils.intToBoolArray(b=readData[1]*8+integer(readData[2]/32), N=11);
          for x in 1:8 loop
            Data[1+8*(x-1):8*x] := utils.intToBoolArray(b=readData[x+2], N=8);
          end for;
          ArbData := cat(1, ID, {RTR});
          CRC := fill(true, 15);
          CRCE := true;
          ACK := true;
          ACKE := true;
          EOF := fill(true, 7);
          finishReadingFromBuffer := true;
        end if;
      end if;
    end when;
    when Wait.active then
      frameInfo := 0;
      IDE := false;
      RTR := false;
      dataLength := 0;
      DLC := fill(false, 4);
      DLC2 := fill(false, 4);
      ID := fill(false, 11);
      Data := fill(false, 64);
      readData := fill(0, 10);
      ArbData := fill(false, 12);
      finishSendingToCAN := false;
      finishReadStartSend := false;
    end when;
    when ReadFromBuffer.active then
        startSend1 := false;
        i := 0;
        frameInfo := TxFrameInfo;
        IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
        RTR := if frameInfo>=128 then true else false;
        dataLength := mod(frameInfo, 16);
        temp := dataLength;
        
        DLC2[1] := if temp >= integer(2^3) then true else false;
        temp := if DLC2[1] then temp-integer(2^3) else temp;
        DLC2[2] := if temp >= integer(2^2) then true else false;
        temp := if DLC2[2] then temp-integer(2^2) else temp;
        DLC2[3] := if temp >= integer(2^1) then true else false;
        temp := if DLC2[3] then temp-integer(2^1) else temp;
        DLC2[4] := if temp >= integer(2^0) then true else false;
        temp := if DLC2[4] then temp-integer(2^0) else temp;
    
        DLC := utils.intToBoolArray(b=dataLength, N=4);
      end when;
    when sendingFrame.active then
//sendingFrame
      finishReadingFromBuffer := false;
      finishReadStartSend := true;
    end when;
    when startSend then
//sendingFrame
      startSend1 := true;
    end when;
    
    when finishedSend then
//sendingFrame
      finishSendingToCAN := true;
      finishReadStartSend := false;
    end when;
//===========================================================
    equation
      
      dataLengthout = dataLength*8;
      connect(Wait.outPort[1], startSendSignal.inPort) annotation(
        Line(points = {{-30.5, 2}, {-24.5, 2}}));
      connect(startSendSignal.outPort, ReadFromBuffer.inPort[1]) annotation(
        Line(points = {{-19.5, 2}, {-11.5, 2}}));
      connect(ReadFromBuffer.outPort[1], finishReading.inPort) annotation(
        Line(points = {{9.5, 2}, {15.5, 2}}));
      connect(finishReading.outPort, sendingFrame.inPort[1]) annotation(
        Line(points = {{20.5, 2}, {28.5, 2}}));
      connect(sendingFrame.outPort[1], finishSendingFrame.inPort) annotation(
        Line(points = {{49.5, 2}, {55.5, 2}}));
      connect(finishSendingFrame.outPort, Wait.inPort[1]) annotation(
        Line(points = {{60.5, 2}, {68.5, 2}, {68.5, 22}, {-61.5, 22}, {-61.5, 2}, {-51.5, 2}}));
      connect(startToSend.y, startSendSignal.condition) annotation(
        Line(points = {{-30, -32}, {-22, -32}, {-22, -10}}, color = {255, 0, 255}));
      connect(finishReadingFromBuffer1.y, finishReading.condition) annotation(
        Line(points = {{10, -32}, {18, -32}, {18, -10}}, color = {255, 0, 255}));
      connect(finishSending.y, finishSendingFrame.condition) annotation(
        Line(points = {{50, -32}, {58, -32}, {58, -10}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-80, 10}, {80, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startSend"), Text(origin = {-50, 40}, extent = {{-30, 10}, {30, -10}}, textString = "readInt"), Text(origin = {-50, 10}, extent = {{-30, 10}, {30, -10}}, textString = "readTag"), Text(origin = {-50, -20}, extent = {{-30, 10}, {30, -10}}, textString = "TxFrameInfo"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {-30, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishedSend"), Text(origin = {46, 50}, extent = {{-30, 10}, {30, -10}}, textString = "ID"), Text(origin = {46, 30}, extent = {{-30, 10}, {30, -10}}, textString = "IDE"), Text(origin = {46, 10}, extent = {{-30, 10}, {30, -10}}, textString = "RTR"), Text(origin = {46, -10}, extent = {{-30, 10}, {30, -10}}, textString = "DLC"), Text(origin = {46, -30}, extent = {{-30, 10}, {30, -10}}, textString = "dataLength"), Text(origin = {46, -50}, extent = {{-30, 10}, {30, -10}}, textString = "Data"), Text(origin = {46, 70}, extent = {{-30, 10}, {30, -10}}, textString = "ArbData"), Text(origin = {50, -70}, extent = {{-30, 10}, {30, -10}}, textString = "finishReadStartSend")}),
    Diagram(graphics));
    end ReadFromBufferStateMech;
  
  
    model WriteToBuffer
  Modelica.StateGraph.InitialStepWithSignal Wait(nOut = 1, nIn = 1)  annotation(
        Placement(transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal start annotation(
        Placement(transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Write(nIn = 1, nOut = 1)  annotation(
        Placement(transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finish annotation(
        Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput startWrite annotation(
        Placement(transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput finishWrite annotation(
        Placement(transformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.IntegerOutput writeData annotation(
        Placement(transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput writeSignal annotation(
        Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput clk annotation(
        Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
    input Integer Data[10];
    input Integer writeDataLength;
    Integer count(start = 1);
    Boolean waitToWrite(start = false);
    Boolean delayToWait(start = false);
  Modelica.Blocks.Sources.BooleanExpression toWrite(y = waitToWrite)  annotation(
        Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Delay(nIn = 1, nOut = 1)  annotation(
        Placement(transformation(origin = {10, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.StateGraph.TransitionWithSignal finishDelay annotation(
        Placement(transformation(origin = {-10, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = delayToWait)  annotation(
        Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}})));
    initial algorithm
      finishWrite := false;
      writeSignal := false;
      writeData := 0;
    algorithm
      when startWrite then
        waitToWrite :=true;
      end when;
      when clk then
        if Wait.active then
          if finishWrite then
            finishWrite := false;
          end if;
        elseif Write.active then
          if delayToWait then
            delayToWait := false;
          end if;
          if count<= 10 then
            if not writeSignal then
              writeData := Data[count];
              writeSignal := true;
            else
              writeSignal := false;
              count := count + 1;
            end if;
          else
            finishWrite := true;
            count := 1;
          end if;
        elseif Delay.active then
          if waitToWrite then
            waitToWrite := false;
          end if;
          delayToWait := true;
        end if;
      end when;
    
    
    equation
  connect(Wait.outPort[1], start.inPort) annotation(
        Line(points = {{-20, 10}, {-14, 10}}));
  connect(start.outPort, Write.inPort[1]) annotation(
        Line(points = {{-8, 10}, {0, 10}}));
  connect(Write.outPort[1], finish.inPort) annotation(
        Line(points = {{20, 10}, {26, 10}}));
  connect(finishWrite, finish.condition) annotation(
        Line(points = {{90, 70}, {46, 70}, {46, -20}, {30, -20}, {30, -2}}, color = {255, 0, 255}));
  connect(toWrite.y, start.condition) annotation(
        Line(points = {{-18, -30}, {-10, -30}, {-10, -2}}, color = {255, 0, 255}));
  connect(finish.outPort, Delay.inPort[1]) annotation(
        Line(points = {{32, 10}, {40, 10}, {40, 50}, {22, 50}}));
  connect(Delay.outPort[1], finishDelay.inPort) annotation(
        Line(points = {{0, 50}, {-6, 50}}));
  connect(finishDelay.outPort, Wait.inPort[1]) annotation(
        Line(points = {{-12, 50}, {-50, 50}, {-50, 10}, {-40, 10}}));
  connect(booleanExpression.y, finishDelay.condition) annotation(
        Line(points = {{-18, 30}, {-10, 30}, {-10, 38}}, color = {255, 0, 255}));
    annotation(
        Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 90}, extent = {{-60, 10}, {60, -10}}, textString = "%name"), Text(origin = {-50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "startWrite"), Text(origin = {-50, -50}, extent = {{-30, 10}, {30, -10}}, textString = "clk"), Text(origin = {50, 70}, extent = {{-30, 10}, {30, -10}}, textString = "finishWrite"), Text(origin = {50, 30}, extent = {{-30, 10}, {30, -10}}, textString = "writeData"), Text(origin = {50, -10}, extent = {{-30, 10}, {30, -10}}, textString = "writeSignal")}),
  Diagram(graphics));
  end WriteToBuffer;
  
  end Core;

  model CANCore4
  Core.CANCoreStateMech cANCoreStateMech annotation(
      Placement(transformation(origin = {-0.642859, -0.555554}, extent = {{-36.3571, -56.5555}, {36.3571, 56.5555}})));
  //=================================================
  Boolean ID[11](start = fill(false, 11));
  Boolean RTR(start = false);
  Boolean ArbData[12](start = fill(false, 12));
  Boolean IDE(start = false);
  Boolean DLC[4](start = fill(false, 4));
  Integer dataLengthout(start = 0);
  Boolean Data[64](start = fill(false, 64));
  Boolean CRC[15](start = fill(false, 15));
  Boolean CRCE(start = false);
  Boolean ACK(start = false);
  Boolean ACKE(start = false);
  Boolean EOF[7](start = fill(false, 7));
  //=================================================
    Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
      Placement(transformation(origin = {-100, 10}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-92, 10}, extent = {{-20, -20}, {20, 20}})));
  initial algorithm
    cANCoreStateMech.sending := false;
    cANCoreStateMech.sendWaiting := false;
    cANCoreStateMech.dataLength := 0;
    cANCoreStateMech.readDataLength := 0;
    cANCoreStateMech.receiving := false;
    cANCoreStateMech.changeToReceive := false;
    cANCoreStateMech.noDataToSend := false;
    cANCoreStateMech.startReadingFromBuffer := false;
    cANCoreStateMech.finishReadingFromBuffer := false;
    cANCoreStateMech.finishWritingToBuffer := false;
  algorithm  //杩愯閫昏緫閮ㄥ垎
//=================================================
//鐘舵€侀€昏緫
    when cANCoreStateMech.txPoint then
      if cANCoreStateMech.canCoreState == 1 then
  //绌洪棽鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 21 then        //璇诲彇Buffer鍐呭鐘舵€?

      elseif cANCoreStateMech.canCoreState == 2 then
//鍚屾鐘舵€?
        Tx := false;
//鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      finishSendingToCAN := false;
      finishReceivingFromCAN := false;
  //      readFromBufferStateMech.finishedSend := false;
elseif cANCoreStateMech.canCoreState == 3 then
//浠茶鍏煎彂閫佺姸鎬?
        Tx := readFromBufferStateMech.ArbData[cANCoreStateMech.bitCounting];
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 4 then
  //鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 5 then
//鍙戦€両DE鐘舵€?
        Tx := readFromBufferStateMech.IDE;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 6 then
//鍙戦€乺0鐘舵€?
        Tx := r0;
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 7 then
//鍙戦€丏LC鐘舵€?
        Tx := readFromBufferStateMech.DLC[cANCoreStateMech.bitCounting - 14];
  //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
elseif cANCoreStateMech.canCoreState == 8 then
  //鎺ユ敹DLC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 9 then
//鍙戦€丏ata鐘舵€?
        Tx := readFromBufferStateMech.Data[cANCoreStateMech.bitCounting - 18];
      elseif cANCoreStateMech.canCoreState == 10 then
  //鎺ユ敹Data鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 11 then
//鍙戦€丆RC鐘舵€?
        Tx := CRC[cANCoreStateMech.bitCounting - 18 - readFromBufferStateMech.dataLength*8];
      elseif cANCoreStateMech.canCoreState == 12 then
  //鎺ユ敹CRC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 13 then
//鍙戦€丆RCE鐘舵€?
        Tx := CRCE;
      elseif cANCoreStateMech.canCoreState == 14 then
  //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 15 then
//鍙戦€丄CK鐘舵€?
        Tx := true;
      elseif cANCoreStateMech.canCoreState == 16 then
//鎺ユ敹ACK鐘舵€?
        Tx := false;
      elseif cANCoreStateMech.canCoreState == 17 then
//鍙戦€丄CKE鐘舵€?
        Tx := true;
      elseif cANCoreStateMech.canCoreState == 18 then
  //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 19 then
//鍙戦€丒OF鐘舵€?
        Tx := true;
        if cANCoreStateMech.bitCounting >= (43 + readFromBufferStateMech.dataLength*8) then
          cANCoreStateMech.sending := false;
          cANCoreStateMech.sendWaiting := false;
          finishSendingToCAN := true;
//readFromBufferStateMech.finishedSend := true;
        end if;
      elseif cANCoreStateMech.canCoreState == 20 then
//鎺ユ敹EOF鐘舵€?
        if cANCoreStateMech.bitCounting >= (43 + readDataLength) then
          cANCoreStateMech.receiving := false;
          finishReceivingFromCAN := true;
          cANCoreStateMech.changeToReceive := false;
        end if;
      end if;
    end when;
//=========================================================================================================
    when cANCoreStateMech.rxPoint then
      if cANCoreStateMech.canCoreState == 1 then
  //绌洪棽鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 2 then
  //鍚屾鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 3 then
//浠茶鍏煎彂閫佺姸鎬?
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鑻x涓洪珮鑰孯x涓轰綆锛屽垯鐩存帴杩涘叆鎺ユ敹閫昏緫
        Record[cANCoreStateMech.bitCounting] := Rx;
        if Tx and not Rx then
          cANCoreStateMech.changeToReceive := true;
          cANCoreStateMech.sending := false;
          cANCoreStateMech.receiving := true;
        end if;
      elseif cANCoreStateMech.canCoreState == 4 then
//鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
  //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif cANCoreStateMech.canCoreState == 5 then
  //鍙戦€両DE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 6 then
  //鍙戦€乺0鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 7 then
  //鍙戦€丏LC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 8 then
//鎺ユ敹DLC鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
        dlc_received := dlc_received*2 + utils.boolToInt(Rx);
//璁板綍DLC
        if cANCoreStateMech.bitCounting >= 18 then
          readDataLength := dlc_received*8;
//鍥涗釜bit鍚庢洿鏂版暣甯ч暱搴?
          if dlc_received == 0 then
            cANCoreStateMech.noDataToReceive := true;
          else
            cANCoreStateMech.noDataToReceive := false;
          end if;
        end if;
      elseif cANCoreStateMech.canCoreState == 9 then
  //鍙戦€丏ata鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 10 then
  //鎺ユ敹Data鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 11 then
  //鍙戦€丆RC鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 12 then
//鎺ユ敹CRC鐘舵€?
        Record[cANCoreStateMech.bitCounting] := Rx;
        crc_received[cANCoreStateMech.bitCounting - 18 - readDataLength] := Rx;
  //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
elseif cANCoreStateMech.canCoreState == 13 then
  //鍙戦€丆RCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 14 then
  //鎺ユ敹CRCE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 15 then
  //鍙戦€丄CK鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 16 then
  //鎺ユ敹ACK鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 17 then
  //鍙戦€丄CKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 18 then
  //鎺ユ敹ACKE鐘舵€?
//do nothing
elseif cANCoreStateMech.canCoreState == 19 then
  //鍙戦€丒OF鐘舵€?
elseif cANCoreStateMech.canCoreState == 20 then
//鎺ユ敹EOF鐘舵€?
        if cANCoreStateMech.bitCounting >= (43+readDataLength) then
          cANCoreStateMech.receiving := false;
          cANCoreStateMech.changeToReceive := false;
          IDE_received := Record[12];
          RTR_received := Record[13];
          DLC_received := Record[14:17];
          if not cANCoreStateMech.noDataToReceive then
            Data_received[1:readDataLength] := Record[18:17 + readDataLength];
          end if;
          cANCoreStateMech.noDataToReceive := false;
          finishReceivingFromCAN := true;
        end if;
      end if;
    end when;
  equation

  end CANCore4;

  model CANCore5
  //========================================================================
  parameter Real T_Q = 1;
  parameter Integer N_tq = 16;
  parameter Integer PROP_SEG_TQ = 7;
  parameter Boolean forceAckErrorOnce = false;
  parameter Integer maxAutoRetransmissions = 16;
  parameter Integer nodeId(min = 0, max = 2047) = 0;
  parameter Boolean enableReceiveFilter = false;
  //========================================================================
  Modelica.StateGraph.InitialStep Idle(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {-213, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal whenRxLow annotation(
      Placement(transformation(origin = {-187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenRxFalse(y =  sending or receiving) annotation(
      Placement(transformation(origin = {-211, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sync(nIn = 3, nOut = 2) annotation(
      Placement(transformation(origin = {-167, 67}, extent = {{-10, -10}, {10, 10}})));
  Core.BitCounter bitCounter annotation(
      Placement(transformation(origin = {-173, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal bit1 annotation(
      Placement(transformation(origin = {-139, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenbit1(y = (tQCounter.y >= N_tq - 1) and sending) annotation(
      Placement(transformation(origin = {-153, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Arb(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {-117, 67}, extent = {{-10, -10}, {10, 10}})));
  Core.TQCounter tQCounter(N_tq = N_tq) annotation(
      Placement(transformation(origin = {-191, 11}, extent = {{-10, -10}, {10, 10}})));
  Core.TQTimer tQTimer(TQ = T_Q) annotation(
      Placement(transformation(origin = {-211, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Receive(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {-73, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal toReveive annotation(
      Placement(transformation(origin = {-93, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startReceiving annotation(
      Placement(transformation(origin = {-139, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression whenBit1AndNotSending(y = (tQCounter.y >= N_tq - 1) and not sending) annotation(
      Placement(transformation(origin = {-153, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal arbSuccess annotation(
      Placement(transformation(origin = {-93, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount13(y = (bitCounter.y >= 13) and sending) annotation(
      Placement(transformation(origin = {-117, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendIDE(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-73, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ideSend annotation(
      Placement(transformation(origin = {-53, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount14(y = bitCounter.y >= 14) annotation(
      Placement(transformation(origin = {-73, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal Sendr0(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-33, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount15(y = bitCounter.y >= 15) annotation(
      Placement(transformation(origin = {-33, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal r0Send annotation(
      Placement(transformation(origin = {-13, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendDLC(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {7, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcSend annotation(
      Placement(transformation(origin = {27, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19(y = (bitCounter.y >= 19) and not noDataToSend) annotation(
      Placement(transformation(origin = {7, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveDLC(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {7, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ider0Received annotation(
      Placement(transformation(origin = {-13, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dlcReceived annotation(
      Placement(transformation(origin = {27, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendData(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {47, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveData(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {47, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataSend annotation(
      Placement(transformation(origin = {67, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal dataReceived annotation(
      Placement(transformation(origin = {67, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRC(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {87, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveCRC(nIn = 2, nOut = 1) annotation(
      Placement(transformation(origin = {87, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataSend annotation(
      Placement(transformation(origin = {67, 25}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndnoData(y = (bitCounter.y >= 19) and noDataToSend) annotation(
      Placement(transformation(origin = {7, 11}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal noDataReveive annotation(
      Placement(transformation(origin = {67, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcSend annotation(
      Placement(transformation(origin = {107, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendCRCE(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {127, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceSend annotation(
      Placement(transformation(origin = {147, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACK(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {167, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackSend annotation(
      Placement(transformation(origin = {187, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendACKE(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {207, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeSend annotation(
      Placement(transformation(origin = {227, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal SendEOF(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {247, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofSend annotation(
      Placement(transformation(origin = {267, 67}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength(y = bitCounter.y >= (19 + dataLength*8)) annotation(
      Placement(transformation(origin = {47, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength(y = bitCounter.y >= (34 + dataLength*8)) annotation(
      Placement(transformation(origin = {87, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength(y = bitCounter.y >= (35 + dataLength*8)) annotation(
      Placement(transformation(origin = {127, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength(y = bitCounter.y >= (36 + dataLength*8)) annotation(
      Placement(transformation(origin = {167, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength(y = bitCounter.y >= (37 + dataLength*8)) annotation(
      Placement(transformation(origin = {207, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength(y = (bitCounter.y >= (44 + dataLength*8)) and not sendWaiting) annotation(
      Placement(transformation(origin = {247, 41}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crcReceived annotation(
      Placement(transformation(origin = {107, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step ReceiveCRCE(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {127, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal crceReveived annotation(
      Placement(transformation(origin = {147, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACK(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {167, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackReceived annotation(
      Placement(transformation(origin = {187, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveACKE(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {207, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal ackeReceived annotation(
      Placement(transformation(origin = {227, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReceiveEOF(nIn = 1, nOut = 2) annotation(
      Placement(transformation(origin = {247, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal eofReceived annotation(
      Placement(transformation(origin = {267, -13}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal waitSending1 annotation(
      Placement(transformation(origin = {267, -53}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression toReceive1(y = changeToReceive) annotation(
      Placement(transformation(origin = {-117, -35}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount19PlusDataLength1(y = bitCounter.y >= (19 + readDataLength)) annotation(
      Placement(transformation(origin = {46, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount34PlusDataLength1(y = bitCounter.y >= (34 + readDataLength)) annotation(
      Placement(transformation(origin = {86, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount35PlusDataLength1(y = bitCounter.y >= (35 + readDataLength)) annotation(
      Placement(transformation(origin = {126, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount36PlusDataLength1(y = bitCounter.y >= (36 + readDataLength)) annotation(
      Placement(transformation(origin = {166, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount37PlusDataLength1(y = bitCounter.y >= (37 + readDataLength)) annotation(
      Placement(transformation(origin = {206, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression bitCount44PlusDataLength1(y = (bitCounter.y >= (44 + readDataLength)) and not sendWaiting) annotation(
      Placement(transformation(origin = {246, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression4(y = (bitCounter.y >= (44 + readDataLength)) and sendWaiting) annotation(
      Placement(transformation(origin = {246, -68}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep SYNC_SEG(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-205, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ1 annotation(
      Placement(transformation(origin = {-181, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step PROP_SEG(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-161, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ2 annotation(
      Placement(transformation(origin = {-139, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal TQ3 annotation(
      Placement(transformation(origin = {-99, -74}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = tQCounter.y >= 1) annotation(
      Placement(transformation(origin = {-201, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y = tQCounter.y >= PROP_SEG_TQ + 1) annotation(
      Placement(transformation(origin = {-161, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y = tQCounter.y == 0) annotation(
      Placement(transformation(origin = {-119, -106}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal PHASE_SEG2(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-119, -74}, extent = {{-10, -10}, {10, 10}})));
  //======================================================================================
  Integer dataLength(start = 0);
  Integer readDataLength(start = 0);
  Boolean sending(start = false);
  Boolean receiving(start = false);
  Boolean changeToReceive(start = false);
  Boolean noDataToSend(start = false);
  Boolean sendWaiting(start = false);
  Boolean noDataToReceive(start = false);
  Boolean txPoint(start = false);
  Boolean rxPoint(start = false);
  //======================================================================================
  Boolean startReadingFromBuffer(start = false);
  Boolean finishReadingFromBuffer(start = false);
  Boolean finishSendingToCAN(start = false);
  Integer readFromBufferData[10](start = fill(0, 10));
  Integer count(start = 0);
  Integer temp(start = 0);
  Boolean ID[11](start = fill(false, 11));
  Boolean RTR(start = false);
  Boolean ArbData[12](start = fill(false, 12));
  Boolean IDE(start = false);
  Boolean DLC[4](start = fill(false, 4));
  Boolean DLC2[4](start = fill(false, 4));
  Integer dataLengthout(start = 0);
  Boolean Data[64](start = fill(false, 64));
  Boolean CRC[15](start = fill(false, 15));
  Boolean CRCE(start = false);
  Boolean ACK(start = false);
  Boolean ACKE(start = false);
  Boolean EOF[7](start = fill(false, 7));
  Boolean crcInputBits[83](start = fill(false, 83));
  Boolean crcExpected[15](start = fill(false, 15));
  Boolean crcOk(start = false);
  Boolean ackReceivedOk(start = false);
  Boolean crcMismatch(start = false);
  Boolean errorFrameActive(start = false);
  Boolean pendingErrorFrame(start = false);
  Boolean errorRecoveryActive(start = false);
  Boolean startErrorFrame(start = false);
  Boolean busOff(start = false);
  Boolean errorPassive(start = false);
  Boolean ackErrorInjected(start = false);
  Integer errorFrameCounter(start = 0);
  Integer TEC(start = 0);
  Integer REC(start = 0);
  Integer autoRetransmitCount(start = 0);
  Integer lastErrorCode(start = 0) "0 none, 1 CRC, 2 ACK, 3 retry limit";
  parameter Boolean r0 = false;
  //======================================================================================
  Boolean finishReceivingFromCAN(start = false);
  Boolean startSendingToBuffer(start = false);
  Boolean finishSendingToBuffer(start = false);
  Integer count2(start = 1);
  Integer writeToBufferData[10](start = fill(0, 10));
  Boolean Record[108](start = fill(false, 108));
  Integer dlc_received(start = 0);
  Boolean crc_received[15](start = fill(false, 15));
  Boolean ID_received[11](start = fill(false, 11));
  Boolean IDE_received(start = false);
  Boolean RTR_received(start = false);
  Boolean DLC_received[4](start = fill(false, 4));
  Boolean Data_received[64](start = fill(false, 64));
  Boolean readLock(start = false);
  Integer receivedFrameId(start = 0);
  Boolean frameAccepted(start = false);
  Boolean receiveFrameHandled(start = false);
  //======================================================================================
  Modelica.Blocks.Sources.BooleanExpression bitCount19AndNoDataToR(y = (bitCounter.y >= 19) and noDataToReceive)  annotation(
      Placement(transformation(origin = {6, -72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression5(y = (bitCounter.y >= 19) and not noDataToReceive)  annotation(
      Placement(transformation(origin = {6, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep Wait(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-206, -147}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal startSendSignal annotation(
      Placement(transformation(origin = {-178, -147}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal ReadFromBuffer(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-148, -147}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finishReading annotation(
      Placement(transformation(origin = {-114, -147}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.StepWithSignal sendingFrame(nIn = 1, nOut = 1) annotation(
      Placement(transformation(origin = {-82, -147}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.TransitionWithSignal finishSendingFrame annotation(
      Placement(transformation(origin = {-46, -147}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression startToSend(y = startReadingFromBuffer) annotation(
      Placement(transformation(origin = {-198, -181}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression finishReadingFromBuffer1(y = finishReadingFromBuffer) annotation(
      Placement(transformation(origin = {-134, -181}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanExpression finishSending(y = finishSendingToCAN) annotation(
      Placement(transformation(origin = {-66, -181}, extent = {{-10, -10}, {10, 10}})));
  //=================================================
  Modelica.Blocks.Interfaces.IntegerInput TxFrameInfo annotation(
      Placement(transformation(origin = {-260, -70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.BooleanOutput Tx(start = true) annotation(
      Placement(transformation(origin = {310, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput Rx annotation(
      Placement(transformation(origin = {300, -52}, extent = {{20, -20}, {-20, 20}}), iconTransformation(origin = {120, -40}, extent = {{20, -20}, {-20, 20}})));
  Modelica.Blocks.Interfaces.BooleanInput SendFrameSignal annotation(
      Placement(transformation(origin = {-260, 30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 78}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.IntegerInput DataFromBuffer annotation(
      Placement(transformation(origin = {-260, -110}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.BooleanOutput readingControlSignal annotation(
      Placement(transformation(origin = {-242, -40}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, 32}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Interfaces.IntegerOutput DataToBuffer annotation(
      Placement(transformation(origin = {-252, -164}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, -130}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Interfaces.BooleanOutput writingControlSignal annotation(
      Placement(transformation(origin = {-256, -184}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, -170}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput RBS annotation(
      Placement(transformation(origin = {-248, -240}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, -210}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  //=================================================
    Modelica.Blocks.Sources.BooleanPulse clk(period = T_Q)  annotation(
      Placement(transformation(origin = {-60, -98}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Transition transition(condition = (bitCounter.y >= (44 + dataLength*8)) and sendWaiting and not errorRecoveryActive)  annotation(
      Placement(transformation(origin = {268, 24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep WaitToWrite(nOut = 1, nIn = 1)  annotation(
      Placement(transformation(origin = {70, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Transition startWriting(condition = startSendingToBuffer)  annotation(
      Placement(transformation(origin = {110, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Step WriteToBuffer(nIn = 1, nOut = 1)  annotation(
      Placement(transformation(origin = {150, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.Transition finishWriting(condition = finishSendingToBuffer)  annotation(
      Placement(transformation(origin = {190, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.StateGraph.InitialStep ErrorIdle(nIn = 1, nOut = 1);
  Modelica.StateGraph.Transition ErrorStart(condition = startErrorFrame);
  Modelica.StateGraph.StepWithSignal ErrorFlag(nIn = 1, nOut = 1);
  Modelica.StateGraph.Transition ErrorFlagDone(condition = errorFrameCounter >= 6);
  Modelica.StateGraph.StepWithSignal ErrorDelimiter(nIn = 1, nOut = 1);
  Modelica.StateGraph.Transition ErrorDelimiterDone(condition = errorFrameCounter >= 14);
  Modelica.StateGraph.StepWithSignal ErrorIntermission(nIn = 1, nOut = 1);
  Modelica.StateGraph.Transition ErrorRecoveryDone(condition = errorFrameCounter >= 17 and Rx);
  initial algorithm
    Tx := true;
    readingControlSignal := false;
    writingControlSignal := false;
    RBS := false;
    DataToBuffer := 0;
  algorithm  //杩愯閫昏緫閮ㄥ垎
//鐘舵€侀€昏緫
    when Idle.active and not Rx then
      receiving := true;
    end when;
    when finishReceivingFromCAN then
      startSendingToBuffer := true;
      RBS := false;
    end when;
    when SendFrameSignal then
      startReadingFromBuffer := true;
    end when;
    
    when ReadFromBuffer.active then//褰撹繘鍏ヨ鍙朆uffer鐘舵€佹椂杩涜鍙橀噺鍒濆鍖?
      IDE := false;//鏆傚彧鏀寔鏍囧噯鏍煎紡
      RTR := if TxFrameInfo>=64 then true else false;
      dataLength := mod(TxFrameInfo, 16);
      dataLengthout := dataLength*8;
      if dataLength == 0 then
        noDataToSend := true;
      else
        noDataToSend := false;
      end if;
      temp := dataLength;
      DLC2[1] := if temp >= integer(2^3) then true else false;
      temp := if DLC2[1] then temp-integer(2^3) else temp;
      DLC2[2] := if temp >= integer(2^2) then true else false;
      temp := if DLC2[2] then temp-integer(2^2) else temp;
      DLC2[3] := if temp >= integer(2^1) then true else false;
      temp := if DLC2[3] then temp-integer(2^1) else temp;
      DLC2[4] := if temp >= integer(2^0) then true else false;
      temp := if DLC2[4] then temp-integer(2^0) else temp;
      DLC := utils.intToBoolArray(b=dataLength, N=4);
      count := 1;
    elsewhen sendingFrame.active then
      if Idle.active then
        sending := true;
      end if;
    elsewhen clk.y then
//=============璇籅uffer==================
      if ReadFromBuffer.active then
        readingControlSignal := true;
        startReadingFromBuffer := false;
        readLock := true;
      elseif Wait.active then
        finishSendingToCAN := false;
      elseif sendingFrame.active then
        finishReadingFromBuffer := false;
      end if;
//=============鍐橞uffer==================
      if WaitToWrite.active then
        finishSendingToBuffer := false;
      elseif WriteToBuffer.active then
        startSendingToBuffer := false;
        DataToBuffer := writeToBufferData[count2];
        count2 := count2 + 1;
        writingControlSignal := true;
      end if;
    elsewhen not clk.y then
//=============璇籅uffer==================
      if ReadFromBuffer.active and readLock then
        readingControlSignal := false;
        readFromBufferData[count] := DataFromBuffer;
        count := count + 1;
        if count > (dataLength+2) then
          ID := utils.intToBoolArray(b=readFromBufferData[1]*8+integer(readFromBufferData[2]/32), N=11);
          for x in 1:8 loop
            Data[1+8*(x-1):8*x] := utils.intToBoolArray(b=readFromBufferData[x+2], N=8);
          end for;
          ArbData := cat(1, ID, {RTR});
          crcInputBits := fill(false, 83);
          crcInputBits[1] := false;
          crcInputBits[2:12] := ID;
          crcInputBits[13] := RTR;
          crcInputBits[14] := IDE;
          crcInputBits[15] := r0;
          crcInputBits[16:19] := DLC;
          if dataLength > 0 then
            crcInputBits[20:19 + dataLength*8] := Data[1:dataLength*8];
          end if;
          CRC := utils.canCRC15(bits = crcInputBits, bitLength = 19 + dataLength*8);
          CRCE := true;
          ACK := true;
          ACKE := true;
          EOF := fill(true, 7);
          ackReceivedOk := false;
          finishReadingFromBuffer := true;
          readLock := false;
        end if;
      end if;
//=============鍐橞uffer==================
      if WaitToWrite.active then
        finishSendingToBuffer := false;
      elseif WriteToBuffer.active then
        startSendingToBuffer := false;
        writingControlSignal := false;
        if count2 > dlc_received + 2 then
          finishSendingToBuffer := true;
          count2 := 1;
          RBS := true;
          DataToBuffer := 0;
        end if;
      end if;
    end when;
  //=================================================
when txPoint then
      if pendingErrorFrame and (SendACKE.active or ReceiveACKE.active or SendEOF.active or ReceiveEOF.active) then
        errorFrameActive := true;
        pendingErrorFrame := false;
        errorRecoveryActive := true;
        startErrorFrame := true;
        errorFrameCounter := 0;
      end if;
      if TEC >= 128 or REC >= 128 then
        errorPassive := true;
      else
        errorPassive := false;
      end if;
      if TEC >= 256 then
        busOff := true;
      end if;
      if busOff then
        Tx := true;
      elseif ErrorFlag.active then
        startErrorFrame := false;
        if not errorPassive then
          Tx := false;
        else
          Tx := true;
        end if;
        errorFrameCounter := errorFrameCounter + 1;
      elseif ErrorDelimiter.active or ErrorIntermission.active then
        Tx := true;
        errorFrameCounter := errorFrameCounter + 1;
        if ErrorIntermission.active and errorFrameCounter >= 17 and Rx then
          errorFrameActive := false;
          errorRecoveryActive := false;
          startErrorFrame := false;
          errorFrameCounter := 0;
        end if;
      elseif Idle.active then//绌洪棽鐘舵€?        Tx := true;
        Tx := true;
      elseif Sync.active then//鍚屾鐘舵€?
        finishReceivingFromCAN := false;
        if sendWaiting then
          Tx := false;//鍙戦€佽妭鐐瑰湪鍚屾娈靛彂閫丼OF
          sending := true;
        else
          Tx := true;//鎺ユ敹鑺傜偣鍙洃鍚琒OF锛屼笉涓诲姩椹卞姩鎬荤嚎
        end if;
      elseif Arb.active then//浠茶鍏煎彂閫佺姸鎬?
        Tx := ArbData[bitCounter.y];      //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif Receive.active then      //鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
//do nothing
      elseif SendIDE.active then//鍙戦€両DE鐘舵€?
        Tx := IDE;      //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif Sendr0.active then//鍙戦€乺0鐘舵€?
        Tx := r0;      //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif SendDLC.active then//鍙戦€丏LC鐘舵€?
        Tx := DLC[bitCounter.y - 14];      //鍦╰QCounter=1鏃跺彂閫侊紝閬垮厤涓巄itCounter鍚屾椂鍙戠敓鏀瑰彉
      elseif ReceiveDLC.active then      //鎺ユ敹DLC鐘舵€?
//do nothing
      elseif SendData.active then//鍙戦€丏ata鐘舵€?
        Tx := Data[bitCounter.y - 18];
      elseif ReceiveData.active then      //鎺ユ敹Data鐘舵€?
//do nothing
      elseif SendCRC.active then//鍙戦€丆RC鐘舵€?
        Tx := CRC[bitCounter.y - 18 - dataLength*8];
      elseif ReceiveCRC.active then      //鎺ユ敹CRC鐘舵€?
//do nothing
      elseif SendCRCE.active then//鍙戦€丆RCE鐘舵€?
        Tx := CRCE;
      elseif ReceiveCRCE.active then      //鎺ユ敹CRCE鐘舵€?
//do nothing
      elseif SendACK.active then//鍙戦€丄CK鐘舵€?
        Tx := true;
      elseif ReceiveACK.active then//鎺ユ敹ACK鐘舵€?
        crcInputBits := fill(false, 83);
        crcInputBits[1] := false;
        crcInputBits[2:19 + readDataLength] := Record[1:18 + readDataLength];
        crcExpected := utils.canCRC15(bits = crcInputBits, bitLength = 19 + readDataLength);
        crcMismatch := false;
        for i in 1:15 loop
          crcMismatch := crcMismatch or (crcExpected[i] <> crc_received[i]);
        end for;
        crcOk := not crcMismatch;
        if crcOk then
          Tx := false;
        else
          Tx := true;
          pendingErrorFrame := true;
          errorRecoveryActive := true;
          REC := REC + 1;
          lastErrorCode := 1;
        end if;
      elseif SendACKE.active then//鍙戦€丄CKE鐘舵€?        Tx := true;
        Tx := true;
      elseif ReceiveACKE.active then      //鎺ユ敹ACKE鐘舵€?        Tx := true;
        Tx := true;
      elseif SendEOF.active then//鍙戦€丒OF鐘舵€?
        Tx := true;
        if bitCounter.y >= (43 + dataLength*8) then
          sending := false;
          if ackReceivedOk and not errorFrameActive and not pendingErrorFrame then
            finishSendingToCAN := true;
            autoRetransmitCount := 0;
            lastErrorCode := 0;
          elseif autoRetransmitCount > maxAutoRetransmissions or busOff then
            finishSendingToCAN := true;
          else
            finishSendingToCAN := false;
          end if;
//finishedSend := true;
        end if;
      elseif ReceiveEOF.active then      //鎺ユ敹EOF鐘舵€?        Tx := true;
        Tx := true;
      end if;
  //=========================================================================================================
elsewhen rxPoint then
      if Idle.active then      //绌洪棽鐘舵€?
//do nothing
      elseif Sync.active then      //鍚屾鐘舵€?
        dlc_received := 0;
        readDataLength := 0;
        noDataToReceive := false;
        crcOk := false;
        crcMismatch := false;
        Record := fill(false, 108);
        crc_received := fill(false, 15);
        DLC_received := fill(false, 4);
        frameAccepted := false;
        receiveFrameHandled := false;
      elseif Arb.active then//浠茶鍏煎彂閫佺姸鎬?
        Record[bitCounter.y] := Rx;
        if Tx and not Rx then//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鑻x涓洪珮鑰孯x涓轰綆锛屽垯鐩存帴杩涘叆鎺ユ敹閫昏緫
          changeToReceive := true;
          sending := false;
          receiving := true;
        end if;
      elseif Receive.active then//鎺ユ敹ID銆丷TR銆両DE銆乺0鐘舵€?
        Record[bitCounter.y] := Rx;      //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
      elseif SendIDE.active then      //鍙戦€両DE鐘舵€?
//do nothing
      elseif Sendr0.active then      //鍙戦€乺0鐘舵€?
//do nothing
      elseif SendDLC.active then      //鍙戦€丏LC鐘舵€?
//do nothing
      elseif ReceiveDLC.active then//鎺ユ敹DLC鐘舵€?
        Record[bitCounter.y] := Rx;//姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
        if bitCounter.y >= 15 and bitCounter.y <= 18 then
          DLC_received[bitCounter.y - 14] := Rx;
        end if;
        if bitCounter.y >= 18 then//鍥涗釜bit鍚庢洿鏂版暣甯ч暱搴?
          dlc_received := utils.boolArrayToInt(N = 4, x = DLC_received);
          if dlc_received > 8 then
            dlc_received := 8;
          end if;
          readDataLength := dlc_received*8;
          if dlc_received == 0 then
            noDataToReceive := true;
          else
            noDataToReceive := false;
          end if;
        end if;
      elseif SendData.active then      //鍙戦€丏ata鐘舵€?
//do nothing
      elseif ReceiveData.active then//鎺ユ敹Data鐘舵€?
        Record[bitCounter.y] := Rx;      //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
      elseif SendCRC.active then      //鍙戦€丆RC鐘舵€?
//do nothing
      elseif ReceiveCRC.active then//鎺ユ敹CRC鐘舵€?
        Record[bitCounter.y] := Rx;
        crc_received[bitCounter.y - 18 - readDataLength] := Rx;      //姣忓綋鍒拌揪閲囨牱鐐规鏌ワ紝鎺ユ敹Rx
      elseif SendCRCE.active then      //鍙戦€丆RCE鐘舵€?
//do nothing
      elseif ReceiveCRCE.active then      //鎺ユ敹CRCE鐘舵€?//do nothing
        crcOk := crcOk;
      elseif SendACK.active then      //鍙戦€丄CK鐘舵€?        if forceAckErrorOnce and not ackErrorInjected then
        if forceAckErrorOnce and not ackErrorInjected then
          ackReceivedOk := false;
          ackErrorInjected := true;
        else
          ackReceivedOk := not Rx;
        end if;
        if not ackReceivedOk then
          pendingErrorFrame := true;
          errorRecoveryActive := true;
          TEC := TEC + 8;
          autoRetransmitCount := autoRetransmitCount + 1;
          lastErrorCode := 2;
          if autoRetransmitCount > maxAutoRetransmissions then
            lastErrorCode := 3;
            TEC := 256;
            busOff := true;
          end if;
        end if;
      elseif ReceiveACK.active then      //鎺ユ敹ACK鐘舵€?
        crcOk := crcOk;
      elseif SendACKE.active then      //鍙戦€丄CKE鐘舵€?
        crcOk := crcOk;
      elseif ReceiveACKE.active then      //鎺ユ敹ACKE鐘舵€?
        if not Rx then
          crcOk := false;
          pendingErrorFrame := true;
          errorRecoveryActive := true;
          REC := REC + 1;
          lastErrorCode := 4;
        end if;
      elseif SendEOF.active then      //鍙戦€丒OF鐘舵€?
        crcOk := crcOk;
      elseif ReceiveEOF.active then//鎺ユ敹EOF鐘舵€?
        if (not Rx) and not errorRecoveryActive then
          crcOk := false;
          pendingErrorFrame := true;
          errorRecoveryActive := true;
          REC := REC + 1;
          lastErrorCode := 4;
        end if;
        if not receiveFrameHandled then
          receiving := false;
          changeToReceive := false;
          if crcOk then
            ID_received := Record[1:11];
            IDE_received := Record[12];
            RTR_received := Record[13];
            DLC_received := Record[15:18];
            receivedFrameId := utils.boolArrayToInt(N = 11, x = ID_received);
            frameAccepted := (not enableReceiveFilter) or (receivedFrameId == nodeId);
            if frameAccepted then
              writeToBufferData[1] := utils.boolArrayToInt(N=8, x=ID_received[1:8]);
              writeToBufferData[2] := utils.boolArrayToInt(N=3, x=ID_received[9:11])*32+utils.boolToInt(RTR_received)*16+dlc_received;
              writeToBufferData[3:10] := fill(0, 8);
              if not noDataToReceive then
                Data_received[1:readDataLength] := Record[19:18 + readDataLength];
                for k in 1:dlc_received loop
                  writeToBufferData[2+k] := utils.boolArrayToInt(N=8, x=Data_received[8*(k-1)+1:8*k]);
                end for;
              end if;
              finishReceivingFromCAN := true;
            else
              finishReceivingFromCAN := false;
            end if;
          else
            finishReceivingFromCAN := false;
          end if;
          receiveFrameHandled := true;
          noDataToReceive := false;
        end if;
      end if;
    end when;
  equation
    
    txPoint = (tQCounter.y == 1);
    rxPoint = (tQCounter.y == PROP_SEG_TQ + 1);
    sendWaiting = sendingFrame.active;
    connect(ErrorIdle.outPort[1], ErrorStart.inPort);
    connect(ErrorStart.outPort, ErrorFlag.inPort[1]);
    connect(ErrorFlag.outPort[1], ErrorFlagDone.inPort);
    connect(ErrorFlagDone.outPort, ErrorDelimiter.inPort[1]);
    connect(ErrorDelimiter.outPort[1], ErrorDelimiterDone.inPort);
    connect(ErrorDelimiterDone.outPort, ErrorIntermission.inPort[1]);
    connect(ErrorIntermission.outPort[1], ErrorRecoveryDone.inPort);
    connect(ErrorRecoveryDone.outPort, ErrorIdle.inPort[1]);
    connect(whenRxFalse.y, whenRxLow.condition) annotation(
      Line(points = {{-200, 41}, {-188, 41}, {-188, 55}}, color = {255, 0, 255}));
    connect(Idle.outPort[1], whenRxLow.inPort) annotation(
      Line(points = {{-202.5, 67}, {-190.5, 67}}));
    connect(whenRxLow.outPort, Sync.inPort[1]) annotation(
      Line(points = {{-185.5, 67}, {-177.5, 67}}));
    connect(Sync.active, tQCounter.reset) annotation(
      Line(points = {{-167, 56}, {-167, 23}, {-191, 23}, {-191, 18}}, color = {255, 0, 255}));
    connect(Sync.active, tQTimer.reset) annotation(
      Line(points = {{-167, 56}, {-167, 23}, {-211, 23}, {-211, 18}}, color = {255, 0, 255}));
    connect(tQTimer.y, tQCounter.count) annotation(
      Line(points = {{-204, 11}, {-198, 11}}, color = {255, 0, 255}));
    connect(Sync.outPort[1], bit1.inPort) annotation(
      Line(points = {{-156.5, 67}, {-143, 67}}));
    connect(whenbit1.y, bit1.condition) annotation(
      Line(points = {{-142, 41}, {-140, 41}, {-140, 55}}, color = {255, 0, 255}));
    connect(bit1.outPort, Arb.inPort[1]) annotation(
      Line(points = {{-137.5, 67}, {-127.5, 67}}));
    connect(tQCounter.y, bitCounter.count) annotation(
      Line(points = {{-184, 11}, {-180, 11}}, color = {255, 127, 0}));
    connect(Arb.outPort[1], toReveive.inPort) annotation(
      Line(points = {{-106.5, 67}, {-102.5, 67}, {-102.5, -13}, {-97, -13}}));
    connect(toReveive.outPort, Receive.inPort[1]) annotation(
      Line(points = {{-91.5, -13}, {-83.5, -13}}));
    connect(Sync.active, bitCounter.reset) annotation(
      Line(points = {{-167, 56}, {-167, 22}, {-173, 22}, {-173, 18}}, color = {255, 0, 255}));
    connect(Sync.outPort[2], startReceiving.inPort) annotation(
      Line(points = {{-156.5, 67}, {-150.5, 67}, {-150.5, -13}, {-143, -13}}));
    connect(startReceiving.outPort, Receive.inPort[2]) annotation(
      Line(points = {{-137.5, -13}, {-107.5, -13}, {-107.5, -1}, {-87.5, -1}, {-87.5, -13}, {-83.5, -13}}));
    connect(whenBit1AndNotSending.y, startReceiving.condition) annotation(
      Line(points = {{-142, -35}, {-139, -35}, {-139, -25}}, color = {255, 0, 255}));
    connect(Arb.outPort[2], arbSuccess.inPort) annotation(
      Line(points = {{-106.5, 67}, {-96.5, 67}}));
    connect(bitCount13.y, arbSuccess.condition) annotation(
      Line(points = {{-106, 41}, {-94, 41}, {-94, 55}}, color = {255, 0, 255}));
    connect(arbSuccess.outPort, SendIDE.inPort[1]) annotation(
      Line(points = {{-91.5, 67}, {-83.5, 67}}));
    connect(bitCount14.y, ideSend.condition) annotation(
      Line(points = {{-62, 41}, {-54, 41}, {-54, 55}}, color = {255, 0, 255}));
    connect(SendIDE.outPort[1], ideSend.inPort) annotation(
      Line(points = {{-62.5, 67}, {-56.5, 67}}));
    connect(ideSend.outPort, Sendr0.inPort[1]) annotation(
      Line(points = {{-51.5, 67}, {-43.5, 67}}));
    connect(Sendr0.outPort[1], r0Send.inPort) annotation(
      Line(points = {{-22.5, 67}, {-16.5, 67}}));
    connect(SendDLC.outPort[1], dlcSend.inPort) annotation(
      Line(points = {{17.5, 67}, {23.5, 67}}));
    connect(r0Send.outPort, SendDLC.inPort[1]) annotation(
      Line(points = {{-11.5, 67}, {-3.5, 67}}));
    connect(ider0Received.outPort, ReceiveDLC.inPort[1]) annotation(
      Line(points = {{-11.5, -13}, {-3.5, -13}}));
    connect(Receive.outPort[1], ider0Received.inPort) annotation(
      Line(points = {{-62.5, -13}, {-16.5, -13}}));
    connect(ReceiveDLC.outPort[1], dlcReceived.inPort) annotation(
      Line(points = {{17.5, -13}, {23.5, -13}}));
    connect(dlcSend.outPort, SendData.inPort[1]) annotation(
      Line(points = {{28.5, 67}, {36.5, 67}}));
    connect(dlcReceived.outPort, ReceiveData.inPort[1]) annotation(
      Line(points = {{28.5, -13}, {36.5, -13}}));
    connect(SendData.outPort[1], dataSend.inPort) annotation(
      Line(points = {{57.5, 67}, {63, 67}}));
    connect(ReceiveData.outPort[1], dataReceived.inPort) annotation(
      Line(points = {{57.5, -13}, {63.5, -13}}));
    connect(dataReceived.outPort, ReceiveCRC.inPort[1]) annotation(
      Line(points = {{68.5, -13}, {76.5, -13}}));
    connect(dataSend.outPort, SendCRC.inPort[1]) annotation(
      Line(points = {{68.5, 67}, {76, 67}}));
    connect(noDataSend.outPort, SendCRC.inPort[2]) annotation(
      Line(points = {{68.5, 25}, {71, 25}, {71, 67}, {76, 67}}));
    connect(SendDLC.outPort[2], noDataSend.inPort) annotation(
      Line(points = {{17.5, 67}, {19.5, 67}, {19.5, 25}, {63, 25}}));
    connect(bitCount19AndnoData.y, noDataSend.condition) annotation(
      Line(points = {{18, 11}, {58, 11}, {58, 12}, {66, 12}, {66, 13}, {67, 13}}, color = {255, 0, 255}));
    connect(ReceiveDLC.outPort[2], noDataReveive.inPort) annotation(
      Line(points = {{17.5, -13}, {19.5, -13}, {19.5, -53}, {63.5, -53}}));
    connect(noDataReveive.outPort, ReceiveCRC.inPort[2]) annotation(
      Line(points = {{68.5, -53}, {71, -53}, {71, -13}, {77, -13}}));
    connect(bitCount19PlusDataLength.y, dataSend.condition) annotation(
      Line(points = {{58, 41}, {62, 41}, {62, 54}, {66, 54}, {66, 55}, {67, 55}}, color = {255, 0, 255}));
    connect(SendCRC.outPort[1], crcSend.inPort) annotation(
      Line(points = {{97.5, 67}, {103.5, 67}}));
    connect(crcSend.outPort, SendCRCE.inPort[1]) annotation(
      Line(points = {{108.5, 67}, {116.5, 67}}));
    connect(SendCRCE.outPort[1], crceSend.inPort) annotation(
      Line(points = {{137.5, 67}, {143.5, 67}}));
    connect(crceSend.outPort, SendACK.inPort[1]) annotation(
      Line(points = {{148.5, 67}, {156.5, 67}}));
    connect(SendACK.outPort[1], ackSend.inPort) annotation(
      Line(points = {{177.5, 67}, {183.5, 67}}));
    connect(ackSend.outPort, SendACKE.inPort[1]) annotation(
      Line(points = {{188.5, 67}, {196.5, 67}}));
    connect(SendACKE.outPort[1], ackeSend.inPort) annotation(
      Line(points = {{217.5, 67}, {223.5, 67}}));
    connect(ackeSend.outPort, SendEOF.inPort[1]) annotation(
      Line(points = {{228.5, 67}, {236.5, 67}}));
    connect(SendEOF.outPort[1], eofSend.inPort) annotation(
      Line(points = {{257.5, 67}, {263.5, 67}}));
    connect(bitCount34PlusDataLength.y, crcSend.condition) annotation(
      Line(points = {{98, 41}, {102, 41}, {102, 55}, {106, 55}}, color = {255, 0, 255}));
    connect(bitCount19.y, dlcSend.condition) annotation(
      Line(points = {{18, 41}, {22, 41}, {22, 55}, {26, 55}}, color = {255, 0, 255}));
    connect(bitCount15.y, r0Send.condition) annotation(
      Line(points = {{-22, 41}, {-18, 41}, {-18, 55}, {-14, 55}}, color = {255, 0, 255}));
    connect(bitCount15.y, ider0Received.condition) annotation(
      Line(points = {{-22, 41}, {-17, 41}, {-17, -25}, {-13, -25}}, color = {255, 0, 255}));
    connect(bitCount35PlusDataLength.y, crceSend.condition) annotation(
      Line(points = {{138, 41}, {142, 41}, {142, 55}, {146, 55}}, color = {255, 0, 255}));
    connect(bitCount36PlusDataLength.y, ackSend.condition) annotation(
      Line(points = {{178, 41}, {182, 41}, {182, 55}, {186, 55}}, color = {255, 0, 255}));
    connect(bitCount37PlusDataLength.y, ackeSend.condition) annotation(
      Line(points = {{218, 41}, {222, 41}, {222, 55}, {226, 55}}, color = {255, 0, 255}));
    connect(bitCount44PlusDataLength.y, eofSend.condition) annotation(
      Line(points = {{258, 41}, {262, 41}, {262, 55}, {266, 55}}, color = {255, 0, 255}));
    connect(ReceiveCRC.outPort[1], crcReceived.inPort) annotation(
      Line(points = {{97.5, -13}, {103.5, -13}}));
    connect(crcReceived.outPort, ReceiveCRCE.inPort[1]) annotation(
      Line(points = {{108.5, -13}, {116.5, -13}}));
    connect(ReceiveCRCE.outPort[1], crceReveived.inPort) annotation(
      Line(points = {{137.5, -13}, {143.5, -13}}));
    connect(crceReveived.outPort, ReceiveACK.inPort[1]) annotation(
      Line(points = {{148.5, -13}, {156.5, -13}}));
    connect(ReceiveACK.outPort[1], ackReceived.inPort) annotation(
      Line(points = {{177.5, -13}, {183.5, -13}}));
    connect(ackReceived.outPort, ReceiveACKE.inPort[1]) annotation(
      Line(points = {{188.5, -13}, {196.5, -13}}));
    connect(ReceiveACKE.outPort[1], ackeReceived.inPort) annotation(
      Line(points = {{217.5, -13}, {223.5, -13}}));
    connect(ackeReceived.outPort, ReceiveEOF.inPort[1]) annotation(
      Line(points = {{228.5, -13}, {236.5, -13}}));
    connect(ReceiveEOF.outPort[1], eofReceived.inPort) annotation(
      Line(points = {{257.5, -13}, {263.5, -13}}));
    connect(ReceiveEOF.outPort[2], waitSending1.inPort) annotation(
      Line(points = {{257.5, -13}, {259.5, -13}, {259.5, -53}, {263.5, -53}}));
    connect(eofSend.outPort, Idle.inPort[1]) annotation(
      Line(points = {{268.5, 67}, {280.5, 67}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
    connect(eofReceived.outPort, Idle.inPort[2]) annotation(
      Line(points = {{268.5, -13}, {280.5, -13}, {280.5, 87}, {-231.5, 87}, {-231.5, 67}, {-223.5, 67}}));
    connect(waitSending1.outPort, Sync.inPort[2]) annotation(
      Line(points = {{268.5, -53}, {273, -53}, {273, 83}, {-181, 83}, {-181, 67}, {-177, 67}}));
    connect(bitCount19PlusDataLength1.y, dataReceived.condition) annotation(
      Line(points = {{57, -40}, {67, -40}, {67, -25}}, color = {255, 0, 255}));
    connect(bitCount34PlusDataLength1.y, crcReceived.condition) annotation(
      Line(points = {{97, -40}, {107, -40}, {107, -25}}, color = {255, 0, 255}));
    connect(bitCount35PlusDataLength1.y, crceReveived.condition) annotation(
      Line(points = {{137, -40}, {147, -40}, {147, -25}}, color = {255, 0, 255}));
    connect(bitCount36PlusDataLength1.y, ackReceived.condition) annotation(
      Line(points = {{177, -40}, {187, -40}, {187, -25}}, color = {255, 0, 255}));
    connect(bitCount37PlusDataLength1.y, ackeReceived.condition) annotation(
      Line(points = {{217, -40}, {227, -40}, {227, -25}}, color = {255, 0, 255}));
    connect(bitCount44PlusDataLength1.y, eofReceived.condition) annotation(
      Line(points = {{257, -40}, {267, -40}, {267, -25}}, color = {255, 0, 255}));
    connect(booleanExpression4.y, waitSending1.condition) annotation(
      Line(points = {{257, -68}, {267, -68}, {267, -65}}, color = {255, 0, 255}));
    connect(toReceive1.y, toReveive.condition) annotation(
      Line(points = {{-106, -35}, {-94, -35}, {-94, -25}}, color = {255, 0, 255}));
    connect(SYNC_SEG.outPort[1], TQ1.inPort) annotation(
      Line(points = {{-194.5, -74}, {-184.5, -74}}));
    connect(TQ1.outPort, PROP_SEG.inPort[1]) annotation(
      Line(points = {{-179.5, -74}, {-171.5, -74}}));
    connect(PROP_SEG.outPort[1], TQ2.inPort) annotation(
      Line(points = {{-150.5, -74}, {-142.5, -74}}));
    connect(TQ3.outPort, SYNC_SEG.inPort[1]) annotation(
      Line(points = {{-97.5, -74}, {-93.5, -74}, {-93.5, -94}, {-221.5, -94}, {-221.5, -74}, {-215.5, -74}}));
    connect(booleanExpression1.y, TQ1.condition) annotation(
      Line(points = {{-190, -106}, {-182, -106}, {-182, -86}}, color = {255, 0, 255}));
    connect(booleanExpression2.y, TQ2.condition) annotation(
      Line(points = {{-150, -106}, {-140, -106}, {-140, -86}}, color = {255, 0, 255}));
    connect(booleanExpression3.y, TQ3.condition) annotation(
      Line(points = {{-108, -106}, {-100, -106}, {-100, -86}}, color = {255, 0, 255}));
    connect(TQ2.outPort, PHASE_SEG2.inPort[1]) annotation(
      Line(points = {{-137.5, -74}, {-129.5, -74}}));
    connect(PHASE_SEG2.outPort[1], TQ3.inPort) annotation(
      Line(points = {{-108.5, -74}, {-102.5, -74}}));
    connect(bitCount19AndNoDataToR.y, noDataReveive.condition) annotation(
      Line(points = {{17, -72}, {65, -72}, {65, -64}, {68, -64}}, color = {255, 0, 255}));
    connect(booleanExpression5.y, dlcReceived.condition) annotation(
      Line(points = {{18, -38}, {28, -38}, {28, -24}}, color = {255, 0, 255}));
    connect(Wait.outPort[1], startSendSignal.inPort) annotation(
      Line(points = {{-195.5, -147}, {-181.5, -147}}));
    connect(startSendSignal.outPort, ReadFromBuffer.inPort[1]) annotation(
      Line(points = {{-176.5, -147}, {-159, -147}}));
    connect(ReadFromBuffer.outPort[1], finishReading.inPort) annotation(
      Line(points = {{-137.5, -147}, {-118, -147}}));
    connect(finishReading.outPort, sendingFrame.inPort[1]) annotation(
      Line(points = {{-112.5, -147}, {-93, -147}}));
    connect(sendingFrame.outPort[1], finishSendingFrame.inPort) annotation(
      Line(points = {{-71.5, -147}, {-50, -147}}));
    connect(finishSendingFrame.outPort, Wait.inPort[1]) annotation(
      Line(points = {{-44.5, -147}, {-32.5, -147}, {-32.5, -127}, {-230.5, -127}, {-230.5, -147}, {-217, -147}}));
    connect(startToSend.y, startSendSignal.condition) annotation(
      Line(points = {{-187, -181}, {-179, -181}, {-179, -159}}, color = {255, 0, 255}));
    connect(finishReadingFromBuffer1.y, finishReading.condition) annotation(
      Line(points = {{-123, -181}, {-115, -181}, {-115, -159}}, color = {255, 0, 255}));
    connect(finishSending.y, finishSendingFrame.condition) annotation(
      Line(points = {{-55, -181}, {-47, -181}, {-47, -159}}, color = {255, 0, 255}));
    connect(SendEOF.outPort[2], transition.inPort) annotation(
      Line(points = {{258, 68}, {260, 68}, {260, 24}, {264, 24}}));
    connect(transition.outPort, Sync.inPort[3]) annotation(
      Line(points = {{270, 24}, {274, 24}, {274, 84}, {-182, 84}, {-182, 68}, {-178, 68}}));
  connect(WaitToWrite.outPort[1], startWriting.inPort) annotation(
      Line(points = {{80, -150}, {106, -150}}));
  connect(startWriting.outPort, WriteToBuffer.inPort[1]) annotation(
      Line(points = {{112, -150}, {140, -150}}));
  connect(WriteToBuffer.outPort[1], finishWriting.inPort) annotation(
      Line(points = {{160, -150}, {186, -150}}));
  connect(finishWriting.outPort, WaitToWrite.inPort[1]) annotation(
      Line(points = {{192, -150}, {212, -150}, {212, -130}, {50, -130}, {50, -150}, {60, -150}}));
    annotation(
      Diagram(coordinateSystem(extent = {{-280, 100}, {320, -200}}), graphics),
  Documentation(info = "<html><head></head><body><div>鐘舵€佸涓嬶細</div><ol><li>Idle</li><li>Sync</li><li>Arb</li><li>Receive</li><li>SendIDE</li><li>Sendr0</li><li>SendDLC</li><li>ReceiveDLC</li><li>SendData</li><li>ReceiveData</li><li>SendCRC</li><li>ReceiveCRC</li><li>SendCRCE</li><li>ReceiveCRCE</li><li>SendACK</li><li>ReceiveACK</li><li>SendACKE</li><li>ReceiveACKE</li><li>SendEOF</li><li>ReceiveEOF</li></ol></body></html>"),
  Icon(graphics = {Rectangle(origin = {0, -60}, extent = {{-100, 160}, {100, -160}}), Text(origin = {-70, 80}, extent = {{-30, 20}, {30, -20}}, textString = "SendFrameSignal"), Text(origin = {-70, 30}, extent = {{-30, 20}, {30, -20}}, textString = "readingControlSignal"), Text(origin = {-70, -20}, extent = {{-30, 20}, {30, -20}}, textString = "TxFrameInfo"), Text(origin = {-70, -80}, extent = {{-30, 20}, {30, -20}}, textString = "DataFromBuffer"), Text(origin = {70, 80}, extent = {{-30, 20}, {30, -20}}, textString = "Tx"), Text(origin = {70, -40}, extent = {{-30, 20}, {30, -20}}, textString = "Rx"), Text(origin = {-70, -130}, extent = {{-30, 20}, {30, -20}}, textString = "DataToBuffer"), Text(origin = {-70, -170}, extent = {{-30, 20}, {30, -20}}, textString = "writingControlSignal"), Text(origin = {-70, -210}, extent = {{-30, 20}, {30, -20}}, textString = "RBS")}, coordinateSystem(extent = {{-140, 100}, {140, -220}})),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian -d=bltdump");
  end CANCore5;

  model CANPhysicalConnector
    parameter Real commonModeRatio = 0.5;
    parameter Modelica.Units.SI.Voltage dominantDiff = 2.0;
    parameter Modelica.Units.SI.Voltage threshold = 0.9;
    parameter Modelica.Units.SI.Conductance dominantTransconductance = 1.0;
    parameter Modelica.Units.SI.Current maxDominantCurrent = 0.06;
    parameter Modelica.Units.SI.Resistance dominantOutputResistance = 5;
    parameter Modelica.Units.SI.Resistance recessiveBiasResistance = 1000000;
    Modelica.Blocks.Interfaces.BooleanInput Tx annotation(
      Placement(transformation(origin = {-110, 60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.BooleanOutput Rx annotation(
      Placement(transformation(origin = {-110, -54}, extent = {{10, -10}, {-10, 10}}), iconTransformation(origin = {-110, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    Modelica.Electrical.Analog.Interfaces.Pin CAN_H annotation(
      Placement(transformation(origin = {102, 60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.Pin CAN_L annotation(
      Placement(transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin VCC annotation(
      Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin GND annotation(
      Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}})));
  protected
    Modelica.Units.SI.Voltage Vcm;
    Modelica.Units.SI.Voltage Vdiff;
    Modelica.Units.SI.Voltage dominantHighTarget;
    Modelica.Units.SI.Voltage dominantLowTarget;
  equation
    Vcm = GND.v + commonModeRatio*(VCC.v - GND.v);
    Vdiff = CAN_H.v - CAN_L.v;
    dominantHighTarget = Vcm + dominantDiff/2;
    dominantLowTarget = Vcm - dominantDiff/2;
    CAN_H.i = (CAN_H.v - Vcm)/recessiveBiasResistance + (if not Tx then (CAN_H.v - dominantHighTarget)/dominantOutputResistance else 0);
    CAN_L.i = (CAN_L.v - Vcm)/recessiveBiasResistance + (if not Tx then (CAN_L.v - dominantLowTarget)/dominantOutputResistance else 0);
    VCC.i = 0;
    GND.i = 0;
    Rx = Vdiff < threshold;
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 70}, extent = {{-20, 10}, {20, -10}}, textString = "VCC"), Text(origin = {0, -70}, extent = {{-20, 10}, {20, -10}}, textString = "GND"), Text(origin = {-80, -60}, extent = {{-20, 10}, {20, -10}}, textString = "Rx"), Text(origin = {-80, 60}, extent = {{-20, 10}, {20, -10}}, textString = "Tx"), Text(origin = {70, -60}, extent = {{-20, 10}, {20, -10}}, textString = "CAN_L"), Text(origin = {70, 60}, extent = {{-20, 10}, {20, -10}}, textString = "CAN_H")}),
      Diagram(graphics));
  end CANPhysicalConnector;

  model CANTwistedPair
    parameter Modelica.Units.SI.Length length = 10;
    parameter Real rPerMeter(unit = "Ohm/m") = 0.07;
    parameter Real lPerMeter(unit = "H/m") = 0.6e-6;
    parameter Real cDiffPerMeter(unit = "F/m") = 40e-12;
    Modelica.Electrical.Analog.Interfaces.Pin H_a annotation(
      Placement(transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.Pin L_a annotation(
      Placement(transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.Pin H_b annotation(
      Placement(transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Interfaces.Pin L_b annotation(
      Placement(transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Resistor rH(R = rPerMeter*length) annotation(
      Placement(transformation(origin = {-42, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Inductor lH(L = lPerMeter*length, i(start = 0, fixed = true)) annotation(
      Placement(transformation(origin = {42, 60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Resistor rL(R = rPerMeter*length) annotation(
      Placement(transformation(origin = {-42, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Inductor lL(L = lPerMeter*length, i(start = 0, fixed = true)) annotation(
      Placement(transformation(origin = {42, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Capacitor cA(C = cDiffPerMeter*length/2, v(start = 0, fixed = true)) annotation(
      Placement(transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Capacitor cB(C = cDiffPerMeter*length/2, v(start = 0, fixed = true)) annotation(
      Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(H_a, rH.p);
    connect(rH.n, lH.p);
    connect(lH.n, H_b);
    connect(L_a, rL.p);
    connect(rL.n, lL.p);
    connect(lL.n, L_b);
    connect(cA.p, H_a);
    connect(cA.n, L_a);
    connect(cB.p, H_b);
    connect(cB.n, L_b);
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, 80}, {100, -80}}), Line(origin = {0, 10}, points = {{-90, 50}, {90, 50}}), Line(origin = {0, -10}, points = {{-90, -50}, {90, -50}}), Text( extent = {{-70, 20}, {70, -20}}, textString = "TwistedPair")}),
      Diagram(coordinateSystem(extent = {{-120, 90}, {120, -90}})));
  end CANTwistedPair;

  model Device
 parameter Real T_Q_500k = 125e-9;
  parameter Real T = 5e-6;
  parameter Integer cache[10] = {69, 6, 34, 1, 2, 170, 170, 121, 0, 0};
  parameter Integer nodeId(min = 0, max = 2047) = 0;
  parameter Boolean enableReceiveFilter = false;
  BusController.CANController sender(T_Q = T_Q_500k, nodeId = nodeId, enableReceiveFilter = enableReceiveFilter) annotation(
      Placement(transformation(origin = {-76, 19}, extent = {{-36, -36}, {36, 36}})));
 BusController.MCU senderMcu(T = T, cache = cache, clk_period = 0.5e-6) annotation(
      Placement(transformation(origin = {-208, 13}, extent = {{-34, -34}, {34, 34}})));
 BusController.CANPhysicalConnector senderPhy annotation(
      Placement(transformation(origin = {-6, 15}, extent = {{-18, -18}, {18, 18}})));
 Modelica.Electrical.Analog.Sources.ConstantVoltage vcc(V = 5) annotation(
      Placement(transformation(origin = {30, 69}, extent = {{-8, -8}, {8, 8}})));
 Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {10, -53}, extent = {{-8, -8}, {8, 8}})));
 Modelica.Electrical.Analog.Interfaces.PositivePin pin_can_H annotation(
      Placement(transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Electrical.Analog.Interfaces.NegativePin pin_can_L annotation(
      Placement(transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(senderMcu.TxFrameInfo, sender.TxFrameInfo) annotation(
      Line(points = {{-177, 10}, {-127.4, 10}, {-127.4, 9}, {-109, 9}}, color = {255, 127, 0}));
    connect(senderMcu.sendData, sender.StartSend) annotation(
      Line(points = {{-177, -11}, {-152.4, -11}, {-152.4, 42}, {-109, 42}}, color = {255, 0, 255}));
    connect(senderMcu.readDataSignal, sender.ReadTrig) annotation(
      Line(points = {{-177, 37}, {-136, 37}, {-136, 29}, {-109, 29}}, color = {255, 0, 255}));
    connect(senderMcu.writeData, sender.WriteData) annotation(
      Line(points = {{-177, 3}, {-109, 3}}, color = {255, 127, 0}));
    connect(senderMcu.writeDataSignal, sender.WriteTrig) annotation(
      Line(points = {{-177, -4}, {-109, -4}}, color = {255, 0, 255}));
    connect(sender.Tx, senderPhy.Tx) annotation(
      Line(points = {{-43, 39}, {-34, 39}, {-34, 25.25}, {-26, 25.25}, {-26, 26}}, color = {255, 0, 255}));
    connect(senderPhy.Rx, sender.Rx) annotation(
      Line(points = {{-26, 4}, {-33.8, 4}, {-33.8, -7}, {-43, -7}}, color = {255, 0, 255}));
    connect(senderPhy.GND, ground.p) annotation(
      Line(points = {{-6, -3}, {-6, -45}, {10, -45}}, color = {0, 0, 255}));
 connect(vcc.p, senderPhy.VCC) annotation(
      Line(points = {{22, 69}, {-6, 69}, {-6, 34}}, color = {0, 0, 255}));
 connect(vcc.n, ground.p) annotation(
      Line(points = {{38, 69}, {54, 69}, {54, -45}, {10, -45}}, color = {0, 0, 255}));
 connect(pin_can_L, senderPhy.CAN_L) annotation(
      Line(points = {{100, -40}, {84, -40}, {84, 4}, {12, 4}}, color = {0, 0, 255}));
 connect(senderPhy.CAN_H, pin_can_H) annotation(
      Line(points = {{12, 26}, {84, 26}, {84, 39}, {100, 39}, {100, 40}}, color = {0, 0, 255}));
 connect(senderMcu.RBS, sender.RBS) annotation(
      Line(points = {{-178, 30}, {-142, 30}, {-142, -10}, {-108, -10}}, color = {255, 0, 255}));
 connect(senderMcu.readData, sender.ReadData) annotation(
      Line(points = {{-178, 24}, {-108, 24}, {-108, 22}}, color = {255, 127, 0}));
    annotation(
      Diagram(coordinateSystem(extent = {{-240, 80}, {120, -60}})),
 Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {60, 40}, extent = {{30, -10}, {-30, 10}}, textString = "CAN_H"), Text(origin = {60, -40}, extent = {{30, -10}, {-30, 10}}, textString = "CAN_L")}));
end Device;
equation

  annotation(
    uses(Modelica(version = "4.0.0")));
end BusController;
