using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1
{
    public class GameField
    {
        int height;
        int width;
        List<Cell> liveCells;
        List<Cell> analyzedCells;
        List<Cell> nextLiveCells;

        public List<Cell> LiveCells
        {
            get
            {
                return liveCells;
            }
        }

        public bool GameState { get; private set; }

        public GameField(List<Cell> startCellList, int h, int w)
        {
            liveCells = startCellList;
            height = h;
            width = w;
            GameState = true;
            RefreshAnalyzedCells();
        }

        public void RefreshAnalyzedCells()
        {
            int x, y;
            List<int[]> tempList;
            analyzedCells = new List<Cell>();
            foreach (Cell cell in liveCells)
            {
                x = cell.X;
                y = cell.Y;
                tempList = GetListCoordinatesSurroundedCells(x, y);

                Cell tempCell;
                CellComparer compCell = new CellComparer();
                foreach (int[] c in tempList)
                {
                    tempCell = new Cell(c[0], c[1]);

                    if (analyzedCells.Find(cellx => compCell.Equals(cellx, tempCell)) == null)
                    {
                        if (liveCells.Find(lCell => compCell.Equals(tempCell, lCell)) != null)
                            tempCell.Revive();
                        analyzedCells.Add(tempCell);
                    }
                }
            }
        }

        public List<int[]> GetListCoordinatesSurroundedCells(int x, int y)
        {
            int[,] resArr = new int[2, 3];
            List<int[]> resList = new List<int[]>();

            // Получение X координат окружающих клетку
            if (x == 0)
            {
                resArr[0, 0] = height - 1;
                resArr[0, 1] = x;
                resArr[0, 2] = x + 1;
            }
            else if (x == height - 1)
            {
                resArr[0, 0] = x - 1;
                resArr[0, 1] = x;
                resArr[0, 2] = 0;
            }
            else
            {
                resArr[0, 0] = x - 1;
                resArr[0, 1] = x;
                resArr[0, 2] = x + 1;
            }

            // Получение Y координат окружающих клетку
            if (y == 0)
            {
                resArr[1, 0] = width - 1;
                resArr[1, 1] = y;
                resArr[1, 2] = y + 1;
            }
            else if (y == width - 1)
            {
                resArr[1, 0] = y - 1;
                resArr[1, 1] = y;
                resArr[1, 2] = 0;
            }
            else
            {
                resArr[1, 0] = y - 1;
                resArr[1, 1] = y;
                resArr[1, 2] = y + 1;
            }

            for (int i = 0; i < 3; i++)
                for (int j = 0; j < 3; j++)
                {
                    resList.Add(new int[] { resArr[0, i], resArr[1, j] });
                }
            resList.RemoveAt(4);
            return resList;
        }

        public void Analyze()
        {

            CellComparer cellComp = new CellComparer();
            nextLiveCells = new List<Cell>(); // "опустошаем список следующих живых клеток"

            List<int[]> coordCell = new List<int[]>();
            List<Cell> surCell;
            foreach (Cell cell in analyzedCells)
            {
                surCell = new List<Cell>();
                coordCell = GetListCoordinatesSurroundedCells(cell.X, cell.Y);
                foreach (int[] coordC in coordCell)
                {
                    Cell cell1;
                    if ((cell1 = analyzedCells.Find(c => c.X == coordC[0] && c.Y == coordC[1])) != null)
                        surCell.Add(cell1);
                    else
                        surCell.Add(new Cell(coordC[0], coordC[1]));
                }

                int liveNeighb = surCell.FindAll(c => c.LifeState == true).Count;

                // если у живой клетки есть две или три живые соседки, то эта клетка продолжает жить; 
                // в противном случае (если соседей меньше двух или больше трёх) клетка умирает («от одиночества» или «от перенаселённости»)
                // в пустой (мёртвой) клетке, рядом с которой ровно три живые клетки, зарождается жизнь;
                if (liveNeighb >= 2 && liveNeighb <= 3)
                {
                    Cell tempCell = new Cell(cell);
                    if (liveNeighb == 3)
                        tempCell.Revive();
                    if (tempCell.LifeState)
                        nextLiveCells.Add(tempCell);
                }

            }

            // на поле не останется ни одной «живой» клетки
            if (nextLiveCells.FindAll(c => c.LifeState == true).Count == 0)
                GameState = false;

            // при очередном шаге ни одна из клеток не меняет своего состояния

            var list3 = liveCells.Except(nextLiveCells, cellComp).ToList();
            if (list3.Count == 0)
                GameState = false;

            liveCells = nextLiveCells;
            RefreshAnalyzedCells();
        }
    }

    public class Cell
    {
        private bool _lifeState;
        private int _x;
        private int _y;
        public int X
        {
            get
            {
                return _x;
            }
        }

        public int Y
        {
            get
            {
                return _y;
            }

        }

        public bool LifeState
        {
            get
            {
                return _lifeState;
            }
        }

        public Cell(int x, int y)
        {
            this._lifeState = false;
            this._x = x;
            this._y = y;
        }

        public Cell(Cell c)
        {
            this._lifeState = c.LifeState;
            this._x = c.X;
            this._y = c.Y;
        }

        public void Revive()
        {
            this._lifeState = true;
        }
        public void Die()
        {
            this._lifeState = false;
        }
        bool Compare(Cell cell)
        {
            if (this._x == cell._x && this._y == cell._y)
                return true;
            return false;
        }
    }
    class CellComparer : IEqualityComparer<Cell>
    {
        public bool Equals(Cell x, Cell y)
        {
            if (Object.ReferenceEquals(x, y))
                return true;
            if (Object.ReferenceEquals(x, null) || Object.ReferenceEquals(y, null))
                return false;
            return x.X == y.X && x.Y == y.Y;
        }

        public int GetHashCode(Cell obj)
        {
            if (object.ReferenceEquals(obj, null))
                return 0;
            int hashCellCoordX = obj.X.GetHashCode();
            int hashCellCoordY = obj.Y.GetHashCode();

            return hashCellCoordX ^ hashCellCoordY;
        }
    }
}
