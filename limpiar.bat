@echo off
cls




echo :: Limpia el proyecto de archivos innecesarios ::
::    /s    Deletes specified files from the current directory and all
::    subdirectories. Displays the names of the files as they are being deleted.
del /s *.bak
del /s *.fxp
del /s tm*.*




echo :: Binario ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\binario
ren pytyvo.dll pytyvo.dll
ren pytyvo.tlb pytyvo.tlb
ren pytyvo.vbr pytyvo.vbr




echo :: Modulos/Barrio ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\barrio
ren barrio.prg barrio.prg
ren barrio_dao_dbf_impl.prg barrio_dao_dbf_impl.prg
ren barrio_dao_factory.prg barrio_dao_factory.prg
ren barrio_vo.prg barrio_vo.prg
ren conexion_barrio_dbf_impl.prg conexion_barrio_dbf_impl.prg
ren conexion_barrio_factory.prg conexion_barrio_factory.prg




echo :: Modulos/Ciudad ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\ciudad
ren ciudad.prg ciudad.prg
ren ciudad_dao_dbf_impl.prg ciudad_dao_dbf_impl.prg
ren ciudad_dao_factory.prg ciudad_dao_factory.prg
ren ciudad_vo.prg ciudad_vo.prg
ren conexion_ciudad_dbf_impl.prg conexion_ciudad_dbf_impl.prg
ren conexion_ciudad_factory.prg conexion_ciudad_factory.prg




echo :: Modulos/Cliente ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\cliente
ren cliente.prg cliente.prg
ren cliente_dao_dbf_impl.prg cliente_dao_dbf_impl.prg
ren cliente_dao_factory.prg cliente_dao_factory.prg
ren cliente_vo.prg cliente_vo.prg
ren conexion_cliente_dbf_impl.prg conexion_cliente_dbf_impl.prg
ren conexion_cliente_factory.prg conexion_cliente_factory.prg




echo :: Modulos/Departamento ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\depar
ren conexion_depar_dbf_impl.prg conexion_depar_dbf_impl.prg
ren conexion_depar_factory.prg conexion_depar_factory.prg
ren depar.prg depar.prg
ren depar_dao_dbf_impl.prg depar_dao_dbf_impl.prg
ren depar_dao_factory.prg depar_dao_factory.prg
ren depar_vo.prg depar_vo.prg




echo :: Modulos/Estado - Ordenes de Trabajo ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\estado_ot
ren estado_ot.prg estado_ot.prg
ren estado_ot_conexion_dbf_impl.prg estado_ot_conexion_dbf_impl.prg
ren estado_ot_conexion_factory.prg estado_ot_conexion_factory.prg
ren estado_ot_dao_dbf_impl.prg estado_ot_dao_dbf_impl.prg
ren estado_ot_dao_factory.prg estado_ot_dao_factory.prg
ren estado_ot_validador_dbf_impl.prg estado_ot_validador_dbf_impl.prg
ren estado_ot_validador_factory.prg estado_ot_validador_factory.prg
ren estado_ot_vo.prg estado_ot_vo.prg




echo :: Modulos/Marca - Ordenes de Trabajo ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\marca_ot
ren marca_ot.prg marca_ot.prg
ren marca_ot_conexion_dbf_impl.prg marca_ot_conexion_dbf_impl.prg
ren marca_ot_conexion_factory.prg marca_ot_conexion_factory.prg
ren marca_ot_dao_dbf_impl.prg marca_ot_dao_dbf_impl.prg
ren marca_ot_dao_factory.prg marca_ot_dao_factory.prg
ren marca_ot_validador_dbf_impl.prg marca_ot_validador_dbf_impl.prg
ren marca_ot_validador_factory.prg marca_ot_validador_factory.prg
ren marca_ot_vo.prg marca_ot_vo.prg




echo :: Modulos/Modelo ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\modelo
ren modelo.prg modelo.prg
ren modelo_conexion_dbf_impl.prg modelo_conexion_dbf_impl.prg
ren modelo_conexion_factory.prg modelo_conexion_factory.prg
ren modelo_dao_dbf_impl.prg modelo_dao_dbf_impl.prg
ren modelo_dao_factory.prg modelo_dao_factory.prg
ren modelo_validador_dbf_impl.prg modelo_validador_dbf_impl.prg
ren modelo_validador_factory.prg modelo_validador_factory.prg
ren modelo_vo.prg modelo_vo.prg




echo :: Modulos/Motivo de ser cliente ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\motivo_clie
ren motivo_clie.prg motivo_clie.prg
ren motivo_clie_conexion_dbf_impl.prg motivo_clie_conexion_dbf_impl.prg
ren motivo_clie_conexion_factory.prg motivo_clie_conexion_factory.prg
ren motivo_clie_dao_dbf_impl.prg motivo_clie_dao_dbf_impl.prg
ren motivo_clie_dao_factory.prg motivo_clie_dao_factory.prg
ren motivo_clie_validador_dbf_impl.prg motivo_clie_validador_dbf_impl.prg
ren motivo_clie_validador_factory.prg motivo_clie_validador_factory.prg
ren motivo_clie_vo.prg motivo_clie_vo.prg




echo :: Modulos/Pais ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\pais
ren pais.prg pais.prg
ren pais_conexion_dbf_impl.prg pais_conexion_dbf_impl.prg
ren pais_conexion_factory.prg pais_conexion_factory.prg
ren pais_dao_dbf_impl.prg pais_dao_dbf_impl.prg
ren pais_dao_factory.prg pais_dao_factory.prg
ren pais_validador_dbf_impl.prg pais_validador_dbf_impl.prg
ren pais_validador_factory.prg pais_validador_factory.prg
ren pais_vo.prg pais_vo.prg




echo :: Modulos/Rubro ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\rubro
ren rubro.prg rubro.prg
ren rubro_conexion_dbf_impl.prg rubro_conexion_dbf_impl.prg
ren rubro_conexion_factory.prg rubro_conexion_factory.prg
ren rubro_dao_dbf_impl.prg rubro_dao_dbf_impl.prg
ren rubro_dao_factory.prg rubro_dao_factory.prg
ren rubro_validador_dbf_impl.prg rubro_validador_dbf_impl.prg
ren rubro_validador_factory.prg rubro_validador_factory.prg
ren rubro_vo.prg rubro_vo.prg




echo :: Modulos/Permiso ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\permiso
ren permiso.prg permiso.prg
ren permiso_conexion_dbf_impl.prg permiso_conexion_dbf_impl.prg
ren permiso_conexion_factory.prg permiso_conexion_factory.prg
ren permiso_dao_dbf_impl.prg permiso_dao_dbf_impl.prg
ren permiso_dao_factory.prg permiso_dao_factory.prg
ren permiso_vo.prg permiso_vo.prg




echo :: Modulos/Cuenta por Cobrar ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\cuenta_por_cobrar
ren conexion_cuenta_por_cobrar_dbf_impl.prg conexion_cuenta_por_cobrar_dbf_impl.prg
ren conexion_cuenta_por_cobrar_factory.prg conexion_cuenta_por_cobrar_factory.prg
ren cuenta_por_cobrar.prg cuenta_por_cobrar.prg
ren cuenta_por_cobrar_dao_dbf_impl.prg cuenta_por_cobrar_dao_dbf_impl.prg
ren cuenta_por_cobrar_dao_factory.prg cuenta_por_cobrar_dao_factory.prg




echo :: Modulos/Plazo ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\plazo
ren conexion_plazo_dbf_impl.prg conexion_plazo_dbf_impl.prg
ren conexion_plazo_factory.prg conexion_plazo_factory.prg
ren plazo.prg plazo.prg
ren plazo_dao_dbf_impl.prg plazo_dao_dbf_impl.prg
ren plazo_dao_factory.prg plazo_dao_factory.prg
ren plazo_vo.prg plazo_vo.prg




echo :: Modulos/Ruta ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\ruta
ren conexion_ruta_dbf_impl.prg conexion_ruta_dbf_impl.prg
ren conexion_ruta_factory.prg conexion_ruta_factory.prg
ren ruta.prg ruta.prg
ren ruta_dao_dbf_impl.prg ruta_dao_dbf_impl.prg
ren ruta_dao_factory.prg ruta_dao_factory.prg
ren ruta_vo.prg ruta_vo.prg




echo :: Modulos/Subrubro ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\subrubro
ren subrubro.prg subrubro.prg
ren subrubro_conexion_dbf_impl.prg subrubro_conexion_dbf_impl.prg
ren subrubro_conexion_factory.prg subrubro_conexion_factory.prg
ren subrubro_dao_dbf_impl.prg subrubro_dao_dbf_impl.prg
ren subrubro_dao_factory.prg subrubro_dao_factory.prg
ren subrubro_validador_dbf_impl.prg subrubro_validador_dbf_impl.prg
ren subrubro_validador_factory.prg subrubro_validador_factory.prg
ren subrubro_vo.prg subrubro_vo.prg




echo :: Modulos/Unidad de Medida ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\unidad_medida
ren unidad_medida.prg unidad_medida.prg
ren unidad_medida_conexion_dbf_impl.prg unidad_medida_conexion_dbf_impl.prg
ren unidad_medida_conexion_factory.prg unidad_medida_conexion_factory.prg
ren unidad_medida_dao_dbf_impl.prg unidad_medida_dao_dbf_impl.prg
ren unidad_medida_dao_factory.prg unidad_medida_dao_factory.prg
ren unidad_medida_validador_dbf_impl.prg unidad_medida_validador_dbf_impl.prg
ren unidad_medida_validador_factory.prg unidad_medida_validador_factory.prg
ren unidad_medida_vo.prg unidad_medida_vo.prg




echo :: Modulos/Maquina ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\maquina
ren maquina.prg maquina.prg
ren maquina_conexion_dbf_impl.prg maquina_conexion_dbf_impl.prg
ren maquina_conexion_factory.prg maquina_conexion_factory.prg
ren maquina_dao_dbf_impl.prg maquina_dao_dbf_impl.prg
ren maquina_dao_factory.prg maquina_dao_factory.prg
ren maquina_validador_dbf_impl.prg maquina_validador_dbf_impl.prg
ren maquina_validador_factory.prg maquina_validador_factory.prg
ren maquina_vo.prg maquina_vo.prg




echo :: Modulos/Usuario ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\usuario
ren conexion_usuario_dbf_impl.prg conexion_usuario_dbf_impl.prg
ren conexion_usuario_factory.prg conexion_usuario_factory.prg
ren usuario.prg usuario.prg
ren usuario_dao_dbf_impl.prg usuario_dao_dbf_impl.prg
ren usuario_dao_factory.prg usuario_dao_factory.prg
ren usuario_vo.prg usuario_vo.prg




echo :: Modulos/Vendedor ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\modulos\vendedor
ren conexion_vendedor_dbf_impl.prg conexion_vendedor_dbf_impl.prg
ren conexion_vendedor_factory.prg conexion_vendedor_factory.prg
ren vendedor.prg vendedor.prg
ren vendedor_dao_dbf_impl.prg vendedor_dao_dbf_impl.prg
ren vendedor_dao_factory.prg vendedor_dao_factory.prg
ren vendedor_vo.prg vendedor_vo.prg




echo :: Nucleo ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\nucleo
ren biblioteca.prg biblioteca.prg
ren com_base.prg com_base.prg
ren conexion.prg conexion.prg
ren conexion_base.prg conexion_base.prg
ren conexion_base_dbf_impl.prg conexion_base_dbf_impl.prg
ren conexion_base_factory.prg conexion_base_factory.prg
ren constantes.h constantes.h
ren dao_base.prg dao_base.prg
ren dao_base_dbf_impl.prg dao_base_dbf_impl.prg
ren dao_factory.prg dao_factory.prg
ren tabla.prg tabla.prg
ren utiles.prg utiles.prg
ren validador_base.prg validador_base.prg
ren validador_base_dbf_impl.prg validador_base_dbf_impl.prg
ren vo_base.prg vo_base.prg




echo :: Proyectos ::
cd\
cd E:\git\pytyvo-com-server-dll\aplicacion\proyectos
ren indizador.pjt indizador.pjt
ren indizador.pjx indizador.pjx
ren pytyvo.pjt pytyvo.pjt
ren pytyvo.pjx pytyvo.pjx




echo :: Restablece la ruta original del proyecto ::
cd E:\git\pytyvo-com-server-dll
