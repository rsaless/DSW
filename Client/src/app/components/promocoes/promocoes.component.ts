import { Component, OnInit } from '@angular/core';
import { ApiService } from "../../services/api.service";
import { Promocao } from '../../models/promocao';

@Component({
  selector: 'app-promocoes',
  templateUrl: './promocoes.component.html',
  styleUrls: ['./promocoes.component.css']
})
export class PromocoesComponent implements OnInit {

  displayedColumns: string[] = ['nome_peca', 'preco', 'dia','hora', 'teatro','site'];
  promocoes: Promocao[] = [];
  isLoadingResults = true;
  query_site: string = '';
  query_teatro: string = '';

  constructor(private api: ApiService) { }

  ngOnInit() {
    this.getData();
  }

  async getData() {
    this.promocoes = await this.api.getPromocoes().toPromise();
    this.isLoadingResults = false;
    console.debug('No issues, I will wait until promise is resolved..');
  }

  async atualizarTabelaSite() {
    this.isLoadingResults = true;
    this.query_teatro = '';
    this.promocoes = await this.api.promocoesPorSite(this.query_site).toPromise();
    this.isLoadingResults = false;
  }

  async atualizarTabelaTeatro() {
    this.isLoadingResults = true;
    this.query_site = '';
    this.promocoes = await this.api.promocoesPorTeatro(this.query_teatro).toPromise();
    this.isLoadingResults = false;
  }


}
