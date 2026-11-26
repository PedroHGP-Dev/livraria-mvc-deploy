package com.mycompany.livrariapedrojoaquim.modelo.entidade;

import java.sql.Timestamp;

public class Venda {

    private int codVenda;
    private Timestamp dataHoraVenda;

    public Venda() {
    }

    public Venda(int codVenda, Timestamp dataHoraVenda) {
        this.codVenda = codVenda;
        this.dataHoraVenda = dataHoraVenda;
    }

    public int getCodVenda() {
        return codVenda;
    }

    public void setCodVenda(int codVenda) {
        this.codVenda = codVenda;
    }

    public Timestamp getDataHoraVenda() {
        return dataHoraVenda;
    }

    public void setDataHoraVenda(Timestamp dataHoraVenda) {
        this.dataHoraVenda = dataHoraVenda;
    }
}