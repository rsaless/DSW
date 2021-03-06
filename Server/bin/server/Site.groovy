package server


import grails.rest.*

@Resource(uri = '/sites', readOnly = false, formats = ['json', 'xml'])
class Site {
    static constraints = {
        email blank: false
        email unique: true
        senha blank: false
        senha unique: false
        url blank: false
        url unique: true
        nome blank: false
        nome unique: false
        telefone blank: false
        telefone unique: false
    }

    String email
    String senha
    String url
    String nome
    Long telefone

    def List<Site> list() {
        return Site.all
    }
}