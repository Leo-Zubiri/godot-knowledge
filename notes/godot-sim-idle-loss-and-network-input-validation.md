# Sim en reposo, pérdidas fuera de tiro y validación de entradas de red

- Si un motor de reglas (FSM) cuenta objetos de la mesa y la simulación física puede quitar uno **fuera de un tiro** (tope de tiempo, un objeto empujado), el reglamento no se entera: hay que **reponerlo** en la sim (punto de rack/salida) o la partida puede no acabar.
- Las pruebas que llaman a `_pocket/_check_off_table` directamente deben marcar «tiro en curso» antes.
- Datos de red (intenciones, posiciones): validar **números finitos** (`is_finite`) y rangos antes de aplicarlos; NaN/inf corrompen la física.
- Guardado de ajustes: agrupar (coalescing) escrituras al disco por ráfaga de cambios.
- Lambdas en `create_timer().timeout.connect` deben comprobar `is_instance_valid` del objeto capturado.
