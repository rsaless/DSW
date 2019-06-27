import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { JWTService } from './services/jwt.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Client';

  constructor(
    private jwtService: JWTService, 
    private router: Router
  ) {}

  logout() {
    this.jwtService.logout();
    this.router.navigate(['/login']);
  }

  public get loggedIn(): boolean {
    return localStorage.getItem('access_token') !== null;
  }

}
