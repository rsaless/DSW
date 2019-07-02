import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { JWTService } from '../services/jwt.service';
import { Site } from '../models/site'
import { ApiService } from '../services/api.service';

@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
    site: Site = null;
    constructor(
        private router: Router,
        private api: ApiService,
        private jwt: JWTService
    ) {}

    canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
        if (this.jwt.isAdmin) return true
        this.router.navigate(['/login'], { queryParams: { returnUrl: state.url }});
        return false;
    }
}
