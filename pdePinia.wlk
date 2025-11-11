/*
Parcial PdePiña LM 03/10/25
https://docs.google.com/document/d/1jpYi80cPj2G-JUO6NN5lPvU6-Wixzp5U9-FL7Vr22Tk/edit?tab=t.0#heading=h.7eva5l6o6uuk

ejercicio 1
a_ FALSO. Por ejemplo en Gimnasio promocionarRango(boxeadora)
b_ FALSO. Depende del rango actual el mensaje que envia. El mensaje debería ser el mismo y cada
    boxeadora "conoce" su rango.
c_ FALSO. Dentro de nuestro dominio, no tiene que lanzar excepción, simplemente no cambiar de rango
*/

class Gimnasio{
    var property boxeadoras = []

    method reevaluarRangoDeBoxeadoras(){
        boxeadoras.forEach({ boxeadora => boxeadora.promocionarRango() })
    }
}

class Boxeadora{
    var experiencia = 100
    var vitalidad = 100
    var resistencia = 10
    var fuerza = 100
    var property ganoUltimaPelea = false 
    var rango = new RangoAmateur()

    method cambiarRango(nuevoRango) {
        rango = nuevoRango
    }

    method promocionarRango() {
        rango.promocionarRango(self)      
    }

    method esExperimentada() = experiencia > 131416 
}

class Rango{
    method experienciaPorPelea(boxeadora) = 10
    method puedePelearPorTitulo(boxeadora) = false
    method promocionarRango(boxeadora)
}

class RangoAmateur inherits Rango{
    override method promocionarRango(boxeadora) {
        if(boxeadora.experiencia()>100)
            boxeadora.cambiarRango(new RangoProfesional())
    }
}

class RangoProfesional inherits Rango{
    override method experienciaPorPelea(boxeadora) {
        if(boxeadora.ganoUltimaPelea()) return 100
        else return 50
    }

    override method puedePelearPorTitulo(boxeadora) = boxeadora.esExperimentada()

    override method promocionarRango(boxeadora) {
        boxeadora.cambiarRango(new RangoCampeona())
    }
}

class RangoCampeona inherits Rango{
    override method experienciaPorPelea(boxeadora) = 20
    override method puedePelearPorTitulo(boxeadora) = true
    override method promocionarRango(boxeadora) {
        // do nothing?
    }
}