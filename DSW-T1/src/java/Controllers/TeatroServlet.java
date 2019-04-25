package Controllers;

import DAO.TeatroDAO;
import DAO.UsuarioDAO;
import Models.Papel;
import Models.Teatro;
import Models.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/teatro/*")
public class TeatroServlet extends HttpServlet {
    
    private TeatroDAO dao;
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        dao = new TeatroDAO();
        usuarioDAO = new UsuarioDAO();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getPathInfo();
        if(action == null) action = "";
        try {
            switch (action){
                case "/cadastro": 
                    apresentaFormCadastro(request, response); 
                    break;
                case "/insercao": 
                    insere(request, response); 
                    break;
                case "/remocao": 
                    remove(request, response); 
                    break;
                case "/edicao": 
                    apresentaFormEdicao(request, response); 
                    break;
                case "/atualizacao": 
                    atualize(request, response); 
                    break;
                case "/lista": 
                    lista(request, response);
                    break;
                default: 
                    erro(request, response);
                    break;
            }
        } catch (RuntimeException | IOException | ServletException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/templates_erro/500.jsp").forward(request, response);
        }
        
    }
    
    private void lista(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Teatro> teatros = dao.listar();
        request.setAttribute("listaTeatros", teatros);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/templates_teatro/listaTeatros.jsp");
        dispatcher.forward(request, response);
    }

    private void apresentaFormCadastro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/templates_teatro/formTeatro.jsp");
        dispatcher.forward(request, response);
    }

    private void apresentaFormEdicao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Teatro teatro = dao.get(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/templates_teatro/formTeatro.jsp");
        request.setAttribute("teatro", teatro);
        dispatcher.forward(request, response);
    }
    
    
    private void insere(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String cidade = request.getParameter("cidade");
        String nome = request.getParameter("nome");
        Integer cnpj = Integer.parseInt(request.getParameter("cnpj"));

        Teatro teatro = new Teatro(email, senha, cidade, nome, cnpj);
        dao.inserir(teatro);
        usuarioDAO.inserir_usuario(new Usuario (email, senha));
        usuarioDAO.inserir_role(new Papel(email, "USER_TEATRO"));
        response.sendRedirect("/DSW-T1/teatro/lista");
    }
    
    
    private void atualize(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        Integer id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String cidade = request.getParameter("cidade");
        String nome = request.getParameter("nome");
        Integer cnpj = Integer.parseInt(request.getParameter("cnpj"));

        Teatro teatro = new Teatro(email, senha, cidade, nome, cnpj, id);
        dao.atualizar(teatro);
        response.sendRedirect("/DSW-T1/teatro/lista");
    }
    

    private void remove(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Teatro teatro = new Teatro(id);
        dao.deletar(teatro);
        response.sendRedirect("/DSW-T1/teatro/lista");
    }
    
    private void erro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        RequestDispatcher dispatcher = request.getRequestDispatcher("/templates_erro/404.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        processRequest(request, response);
    }
}