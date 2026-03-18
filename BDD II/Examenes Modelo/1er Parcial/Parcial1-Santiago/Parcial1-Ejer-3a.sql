SET TERM ^;
CREATE TRIGGER TRG_VALIDAR_PAGO_FACTURA FOR PAGO ACTIVE
BEFORE INSERT POSITION 0
BEGIN
    DECLARE total_pagos DECIMAL;

    -- Obtener la suma de los importes de pagos anteriores de la factura
    SELECT SUM(IMPORTE) INTO total_pagos
    FROM PAGO
    WHERE NRO = NEW.NRO;

    -- Verificar que el (nuevo pago + pagos anteriores) no exceda el monto de la factura
    IF (total_pagos + NEW.IMPORTE) > (SELECT MONTO FROM FACTURA WHERE NRO = NEW.NRO) THEN
        exception MONTO_PAGOS_MAYOR_FACTURA_MONTO;
    END IF;
END^
SET TERM ;^
