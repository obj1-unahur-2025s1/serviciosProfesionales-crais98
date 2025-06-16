class ProfesionalUniversidad {
  var property universidad
  var importe = 0
  method provincias() = universidad.provincias().asList()
  method honorarios(horas) = universidad.honorarios()*horas
  //ETAPA 2
  method puedeAtenderA(unSolicitante) = unSolicitante.puedeSerAtendidoPor(self)
  //ETAPA 3
  method cobrar(unMonto) {
    importe += unMonto/2
    universidad.recibirDonacion(importe)
  }
}

class ProfesionalLitoral{
  var property universidad
  const provincias = ["Entre rios", "Santa fe", "Corrientes"]
  method honorarios(horas) = 3000*horas
  method provincias() = provincias 
  //ETAPA 2
  method puedeAtenderA(unSolicitante) = unSolicitante.puedeSerAtendidoPor(self)
  method cobrar(unMonto) {
    asociacionLitoral.recibirDonacion(unMonto)
  }
}

object asociacionLitoral {
  var recaudacion = 0
  method recibirDonacion(unMonto){
    recaudacion+= unMonto
  }
  method totalRecaudado() = recaudacion 
}

class ProfesionalLibre{
  var property universidad
  var property recaudacion
  var honorarios
  const provincias = []
  //var property honorarios //lo cambio porque necesito poner "horas" como parametro
  method honorarios(horas){
    honorarios = honorarios*horas
  }
  method agregarProvincias(listaDeProvincias) {
    provincias.addAll(listaDeProvincias)
  }
  method provincias() = provincias 


  //ETAPA 2
  method puedeAtenderA(unSolicitante) = unSolicitante.puedeSerAtendidoPor(self)
  //ETAPA 3
  method cobrar(unMonto) {
    recaudacion+= unMonto
  }
  method totalRecaudado() = recaudacion
  method pasarDinero(unProfesional, unMonto) {
    recaudacion -= unMonto
    unProfesional.cobrar(unMonto)
  }
}

class Universidad {
  var provincia// ubicacion de la universidad
  var recaudacion
  const provinciash = [] // provincias habilitadas para un trabajador
  var property honorarios
  method provincias() = provinciash
  method recibirDonacion(unMonto){
    recaudacion+= unMonto
  }
  method totalRecaudado() = recaudacion 
  
}

class Empresa {
  const empleados = []
  const clientes = #{}
  var profesionalAdecuado = self.profesionalAdecuadoPara(unSolicitante)

  var property honorarios
  method cantidadEmpleadosDe(unaUniversidad) = empleados.count({p=>p.universidad() == unaUniversidad}) 
  
  //method profesionalesCaros() = empleados.count({p=>p.honorarios()>self.honorarioReferencia()}).asSet()
  method profesionalesCaros() = empleados.filter({p=>p.honorarios()>honorarios}).asSet()
  
  method universidadesFormadoras() = empleados.map({p=>p.universidad()}).asSet()
  method profesionalMasBarato() = empleados.min({p=>p.honorarios()})
  method esDeGenteAcotada() = empleados.all({p=>p.provincias().size()<=3})// verifica si el tamaño de la lista es <=3
  method contratarEmpleados(unaListaDeEmpleados) {
    empleados.addAll(unaListaDeEmpleados)
  }
  //ETAPA 2
  method puedeSatisfacerA(unSolicitante) = empleados.any({p=>p.puedeAtenderA(unSolicitante)})
  //ETAPA 4
  method darServicio(unSolicitante) {
    if(self.puedeSatisfacerA(unSolicitante)){
      profesionalAdecuado.cobrar(profesionalAdecuado.honorarios(1))// es más legible ahora
      clientes.add(unSolicitante)
    }
  }

  method profesionalAdecuadoPara(unSolicitante) = empleados.anyOne({p=>p.puedeAtenderA(unSolicitante)})

// ETAPA 4

method cantidadDeClientes() = clientes.asList().size()

method tieneACliente(unSolicitante) = clientes.asList().contains(unSolicitante)

}

//ETAPA 2 SOLICITANTES
class Persona {
  var property provincia
  method puedeSerAtendidoPor(unProfesional) = unProfesional.provincias().contains(provincia)
}
class Institucion {
  const universidades = []
  method puedeSerAtendidoPor(unProfesional) = universidades.contains(unProfesional.universidad())
  method agregarUniversidades(unaListaDeUniversidades) {
    universidades.addAll(unaListaDeUniversidades)
  }
}
class Club {
  const provincias = []
  method provincias() = provincias 
  method puedeSerAtendidoPor(unProfesional) =  !provincias.asSet().intersection(unProfesional.provincias().asSet()).isEmpty()
  method agregarProvincias(listaDeProvincias) {
    provincias.addAll(listaDeProvincias)
  }
}